#include <pebble.h>

uint8_t buf[16384];
extern void dut(int count, void *p);

int main(void) {
	uint32_t tmtaken = 0;
	uint32_t reps = 1;
	
	while ((reps < 4*1024*1024) && (tmtaken < 500)) {
		reps *= 2;
		
		printf("Testing %lu reps...", reps);
		time_t s1, s2;
		uint16_t ms1, ms2;
		
		time_ms(&s1, &ms1);
		dut(reps, buf);
		time_ms(&s2, &ms2);
		
		tmtaken = (s2 - s1) * 1000;
		tmtaken += (ms2 - ms1);
	}
	
	uint64_t cyc = tmtaken * 64200000ULL / reps;
	printf("%lu reps in %lu ms (%lu.%03lu cycles / rep)", reps, tmtaken, (uint32_t)(cyc / 1000), (uint32_t)(cyc % 1000));
	
	app_event_loop();
}
