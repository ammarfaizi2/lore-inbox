Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbSK2S76>; Fri, 29 Nov 2002 13:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267128AbSK2S76>; Fri, 29 Nov 2002 13:59:58 -0500
Received: from mail.seciu.edu.uy ([164.73.129.3]:63895 "HELO mail.seciu.edu.uy")
	by vger.kernel.org with SMTP id <S267126AbSK2S7v>;
	Fri, 29 Nov 2002 13:59:51 -0500
Message-ID: <3DE7BB95.716B91DC@seciu.edu.uy>
Date: Fri, 29 Nov 2002 16:10:16 -0300
From: Javier Valena <jvalena@seciu.edu.uy>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: es,es-ES
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Sergio Ramirez <sramirez@seciu.edu.uy>
Subject: Re: Kernel errors - Red Hat 7.3
References: <3DE7B4EC.2AEFB926@seciu.edu.uy>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>      We need  help about kernel errors. We have installed all
> kernel patches, we have changed all memory RAM, but the system
> still reports errors in the kernel.
>
> Bottom are information about our system and the errors messages.
> If you need more information, please let us know.
>
> We appreciate any comment about this problem.
>

--
=======================================================================
Javier Valena                                      jvalena@seciu.edu.uy
Red Académica Uruguaya - RAU
SeCIU-Servicio Central de Informática de la Universidad de la República
Colonia 2066, Montevideo, CP 11200,  Uruguay
Tel. (+5982) 4083901
Fax (+5982) 4015843
=======================================================================


>
> ----------------------------------------------------------------------------
> Following are the Messages when the system start up, in oder to show
> the system.
>
> Nov 23 18:31:26 higiene1 syslogd 1.4.1: restart.
> nov 23 18:31:26 higiene1 syslog: Iniciación de syslogd succeeded
> nov 23 18:31:26 higiene1 syslog: Iniciación de klogd succeeded
> Nov 23 18:31:26 higiene1 kernel: klogd 1.4.1, log source = /proc/kmsg started.
> Nov 23 18:31:26 higiene1 kernel: Linux version 2.4.18-5 (bhcompile@daffy.perf.redhat.com) (gcc version 2.96 20000731
> (Red Hat$
> Nov 23 18:31:26 higiene1 kernel: BIOS-provided physical RAM map:
> Nov 23 18:31:26 higiene1 kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> Nov 23 18:31:26 higiene1 kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> Nov 23 18:31:26 higiene1 kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> Nov 23 18:31:26 higiene1 kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
> Nov 23 18:31:26 higiene1 kernel:  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
> Nov 23 18:31:26 higiene1 kernel:  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
> Nov 23 18:31:26 higiene1 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> Nov 23 18:31:26 higiene1 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> Nov 23 18:31:26 higiene1 kernel:  BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
> Nov 23 18:31:26 higiene1 kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
> Nov 23 18:31:26 higiene1 kernel: 0MB HIGHMEM available.
> Nov 23 18:31:26 higiene1 kernel: 511MB LOWMEM available.
> Nov 23 18:31:26 higiene1 kernel: On node 0 totalpages: 131056
> Nov 23 18:31:26 higiene1 kernel: zone(0): 4096 pages.
> Nov 23 18:31:26 higiene1 kernel: zone(1): 126960 pages.
> Nov 23 18:31:26 higiene1 kernel: zone(2): 0 pages.
> Nov 23 18:31:26 higiene1 kernel: Kernel command line: ro root=/dev/hda2
> Nov 23 18:31:26 higiene1 kernel: Initializing CPU#0
> Nov 23 18:31:26 higiene1 kernel: Detected 1603.676 MHz processor.
> Nov 23 18:31:26 higiene1 kernel: Console: colour VGA+ 80x25
> Nov 23 18:31:26 higiene1 kernel: Calibrating delay loop... 3198.15 BogoMIPS
> Nov 23 18:31:26 higiene1 kernel: Memory: 513952k/524224k available (1118k kernel code, 9884k reserved, 787k data, 292k
> init, $
> Nov 23 18:31:26 higiene1 kernel: Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> Nov 23 18:31:26 higiene1 kernel: Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
> Nov 23 18:31:26 higiene1 kernel: Mount cache hash table entries: 8192 (order: 4, 65536 bytes)
> Nov 23 18:31:26 higiene1 kernel: Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
> Nov 23 18:31:26 higiene1 kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> Nov 23 18:31:26 higiene1 kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
> Nov 23 18:31:26 higiene1 kernel: CPU: L2 cache: 256K
> Nov 23 18:31:26 higiene1 kernel: Intel machine check architecture supported.
> Nov 23 18:31:26 higiene1 kernel: Intel machine check reporting enabled on CPU#0.
> Nov 23 18:31:26 higiene1 kernel: CPU: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 02
> Nov 23 18:31:26 higiene1 kernel: Enabling fast FPU save and restore... done.
> Nov 23 18:31:26 higiene1 kernel: Enabling unmasked SIMD FPU exception support... done.
> Nov 23 18:31:26 higiene1 kernel: Checking 'hlt' instruction... OK.
> Nov 23 18:31:26 higiene1 kernel: POSIX conformance testing by UNIFIX
>
> ------------------------------------------------------------------------------------------------
>
> FOLLOWING ARE THE KERNEL MESSAGES ERRORS:
>
> Nov 19 06:52:07 higiene1 kernel: ------------[ cut here ]------------
> Nov 19 06:52:07 higiene1 kernel: kernel BUG at page_alloc.c:193!
> Nov 19 06:52:07 higiene1 kernel: invalid operand: 0000
> Nov 19 06:52:07 higiene1 kernel: autofs dmfe ide-cd cdrom usb-uhci usbcore ext3 jbd
> Nov 19 06:52:07 higiene1 kernel: CPU:    0
> Nov 19 06:52:07 higiene1 kernel: EIP:    0010:[<c01314fe>]    Not tainted
> Nov 19 06:52:07 higiene1 kernel: EFLAGS: 00010086
> Nov 19 06:52:07 higiene1 kernel:
> Nov 19 06:52:07 higiene1 kernel: EIP is at rmqueue [kernel] 0x13e (2.4.18-5)
> Nov 19 06:52:07 higiene1 kernel: eax: 00000020   ebx: c1000650   ecx: 00000001   edx:
> 00001b5f
> Nov 19 06:52:07 higiene1 kernel: esi: c02c7278   edi: 00000004   ebp: 00000002   esp:
> dc633e34
> Nov 19 06:52:07 higiene1 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 19 06:52:07 higiene1 kernel: Process xfs (pid: 983, stackpage=dc633000)
> Nov 19 06:52:07 higiene1 kernel: Stack: c02251dc 000000c1 00000000 0000001c 00000296
> 00000000 c02c7220 c02c7220
> Nov 19 06:52:07 higiene1 kernel:        c02c74f4 00000000 0000061e c01317f5 d59314a0
> 00000001 c02c74ec 000001d2
> Nov 19 06:52:07 higiene1 kernel:        c1003910 dc800fc4 00104025 dd48cb40 c0125f71
> 00000001 dd48cb40 bfff1000
> Nov 19 06:52:07 higiene1 kernel: Call Trace: [<c01317f5>] __alloc_pages [kernel] 0x75
> Nov 19 06:52:07 higiene1 kernel: [<c0125f71>] do_anonymous_page [kernel] 0x51
> Nov 19 06:52:07 higiene1 kernel: [<c0126054>] do_no_page [kernel] 0x34
> Nov 19 06:52:07 higiene1 kernel: [<c01262aa>] handle_mm_fault [kernel] 0xca
> Nov 19 06:52:07 higiene1 kernel: [<c012723b>] expand_stack [kernel] 0x2b
> Nov 19 06:52:07 higiene1 kernel: [<c0113eca>] do_page_fault [kernel] 0x12a
> Nov 19 06:52:07 higiene1 kernel: [<c0127a49>] do_brk [kernel] 0x249
> Nov 19 06:52:07 higiene1 kernel: [<c011b93b>] bh_action [kernel] 0x1b
> Nov 19 06:52:07 higiene1 kernel: [<c011b84f>] tasklet_hi_action [kernel] 0x4f
> Nov 19 06:52:07 higiene1 kernel: [<c0126795>] sys_brk [kernel] 0xc5
> Nov 19 06:52:07 higiene1 kernel: [<c0113da0>] do_page_fault [kernel] 0x0
> Nov 19 06:52:07 higiene1 kernel: [<c0108a04>] error_code [kernel] 0x34
> Nov 19 06:52:07 higiene1 kernel:
> Nov 19 06:52:07 higiene1 kernel:
> Nov 19 06:52:07 higiene1 kernel: Code: 0f 0b 58 5a 83 ee 0c 4d 8b 06 8d 4d 01 d1 ef 89 58 04
> 89 03
>
> -------------------------------------------------------------------------------
>
> Nov 19 06:57:10 higiene1 kernel:  ------------[ cut here ]------------
> Nov 19 06:57:10 higiene1 kernel: kernel BUG at page_alloc.c:203!
> Nov 19 06:57:10 higiene1 kernel: invalid operand: 0000
> Nov 19 06:57:10 higiene1 kernel: autofs dmfe ide-cd cdrom usb-uhci usbcore ext3 jbd
> Nov 19 06:57:10 higiene1 kernel: CPU:    0
> Nov 19 06:57:10 higiene1 kernel: EIP:    0010:[<c0131588>]    Not tainted
> Nov 19 06:57:10 higiene1 kernel: EFLAGS: 00010096
> Nov 19 06:57:10 higiene1 kernel:
> Nov 19 06:57:10 higiene1 kernel: EIP is at rmqueue [kernel] 0x1c8 (2.4.18-5)
> Nov 19 06:57:10 higiene1 kernel: eax: 00000020   ebx: c1000618   ecx: 00000001   edx:
> 000020b0
> Nov 19 06:57:10 higiene1 kernel: esi: c02c7220   edi: 00001000   ebp: c1000030   esp:
> c30c3e5c
> Nov 19 06:57:10 higiene1 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 19 06:57:10 higiene1 kernel: Process kalarmd (pid: 16230, stackpage=c30c3000)
> Nov 19 06:57:10 higiene1 kernel: Stack: c02251dc 000000cb 00000000 0000001b 00000282
> 00000000 c02c7220 c02c7220
> Nov 19 06:57:10 higiene1 kernel:        c02c74f4 00000000 0000061e c01317f5 c013611e
> 00000001 c02c74ec 000001d2
> Nov 19 06:57:10 higiene1 kernel:        c1601048 c0129d30 00000001 c1ebc5c0 c01260b2
> c1ebc5c0 d64dc0e0 4056d0e4
> Nov 19 06:57:10 higiene1 kernel: Call Trace: [<c01317f5>] __alloc_pages [kernel] 0x75
> Nov 19 06:57:10 higiene1 kernel: [<c013611e>] page_remove_rmap [kernel] 0x9e
> Nov 19 06:57:10 higiene1 kernel: [<c0129d30>] filemap_nopage [kernel] 0x0
> Nov 19 06:57:10 higiene1 kernel: [<c01260b2>] do_no_page [kernel] 0x92
> Nov 19 06:57:10 higiene1 kernel: [<c01262aa>] handle_mm_fault [kernel] 0xca
> Nov 19 06:57:10 higiene1 kernel: [<c0126f49>] do_mmap_pgoff [kernel] 0x559
> Nov 19 06:57:10 higiene1 kernel: [<c0113eca>] do_page_fault [kernel] 0x12a
> Nov 19 06:57:10 higiene1 kernel: [<c011f3b0>] process_timeout [kernel] 0x0
> Nov 19 06:57:11 higiene1 kernel: [<c0114749>] wake_up_process [kernel] 0x9
> Nov 19 06:57:11 higiene1 kernel: [<c011f167>] timer_bh [kernel] 0x257
> Nov 19 06:57:11 higiene1 kernel: [<c010742b>] __switch_to [kernel] 0x2b
> Nov 19 06:57:11 higiene1 kernel: [<c0114dca>] schedule [kernel] 0x21a
> Nov 19 06:57:11 higiene1 kernel: [<c0113da0>] do_page_fault [kernel] 0x0
> Nov 19 06:57:11 higiene1 kernel: [<c0108a04>] error_code [kernel] 0x34
> Nov 19 06:57:11 higiene1 kernel:
> Nov 19 06:57:11 higiene1 kernel:
> Nov 19 06:57:11 higiene1 kernel: Code: 0f 0b 58 5a ff 74 24 08 9d c7 43 14 01 00 00 00 8b 2d
> d0 54
> Nov 19 06:57:11 higiene1 kernel:  <1>Unable to handle kernel paging request at virtual
> address 06800040
> Nov 19 06:57:11 higiene1 kernel:  printing eip:
> Nov 19 06:57:11 higiene1 kernel: c0125fca
> Nov 19 06:57:11 higiene1 kernel: *pde = 00000000
> Nov 19 06:57:11 higiene1 kernel: Oops: 0002
> Nov 19 06:57:11 higiene1 kernel: autofs dmfe ide-cd cdrom usb-uhci usbcore ext3 jbd
> Nov 19 06:57:11 higiene1 kernel: CPU:    0
> Nov 19 06:57:11 higiene1 kernel: EIP:    0010:[<c0125fca>]    Not tainted
> Nov 19 06:57:11 higiene1 kernel: EFLAGS: 00010246
> Nov 19 06:57:11 higiene1 kernel:
> Nov 19 06:57:11 higiene1 kernel: EIP is at do_anonymous_page [kernel] 0xaa (2.4.18-5)
> Nov 19 06:57:11 higiene1 kernel: eax: 00000000   ebx: c10005e0   ecx: 00000400   edx:
> 0000001a
> Nov 19 06:57:11 higiene1 kernel: esi: c401d098   edi: 06800040   ebp: d64dc860   esp:
> c2601d74
> Nov 19 06:57:11 higiene1 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 19 06:57:11 higiene1 kernel: Process kdeinit (pid: 16223, stackpage=c2601000)
> Nov 19 06:57:11 higiene1 kernel: Stack: 00000001 d64dc860 40026000 00000001 c0126054
> d64dc860 d2922a80 c401d098
> Nov 19 06:57:11 higiene1 kernel:        00000001 40026000 d2922a80 d64dc860 40026000
> 00000001 c01262aa d64dc860
> Nov 19 06:57:11 higiene1 kernel:        d2922a80 40026000 00000001 c401d098 c01c4863
> 00000020 000001f0 c01c45c1
> Nov 19 06:57:11 higiene1 kernel: Call Trace: [<c0126054>] do_no_page [kernel] 0x34
> Nov 19 06:57:11 higiene1 kernel: [<c01262aa>] handle_mm_fault [kernel] 0xca
> Nov 19 06:57:11 higiene1 kernel: [<c01c4863>] sock_alloc_send_pskb [kernel] 0x73
> Nov 19 06:57:11 higiene1 kernel: [<c01c45c1>] sock_wfree [kernel] 0x21
> Nov 19 06:57:11 higiene1 kernel: [<c0113eca>] do_page_fault [kernel] 0x12a
> Nov 19 06:57:11 higiene1 kernel: [<c0114e39>] __wake_up [kernel] 0x39
> Nov 19 06:57:11 higiene1 kernel: [<c01317f5>] __alloc_pages [kernel] 0x75
> Nov 19 06:57:11 higiene1 kernel: [<c013602a>] page_add_rmap [kernel] 0x3a
> Nov 19 06:57:11 higiene1 kernel: [<c0126016>] do_anonymous_page [kernel] 0xf6
> Nov 19 06:57:11 higiene1 kernel: [<c0113da0>] do_page_fault [kernel] 0x0
> Nov 19 06:57:11 higiene1 kernel: [<c0108a04>] error_code [kernel] 0x34
> Nov 19 06:57:11 higiene1 kernel: [<c0129660>] file_read_actor [kernel] 0x70
> Nov 19 06:57:11 higiene1 kernel: [<c01291c0>] do_generic_file_read [kernel] 0x210
> Nov 19 06:57:11 higiene1 kernel: [<c012974e>] generic_file_read [kernel] 0x7e
> Nov 19 06:57:11 higiene1 kernel: [<c01295f0>] file_read_actor [kernel] 0x0
> Nov 19 06:57:11 higiene1 kernel: [<c01388d6>] sys_read [kernel] 0x96
> Nov 19 06:57:11 higiene1 kernel: [<c0126795>] sys_brk [kernel] 0xc5
> Nov 19 06:57:11 higiene1 kernel: [<c0138829>] sys_llseek [kernel] 0xc9
> Nov 19 06:57:11 higiene1 kernel: [<c0108913>] system_call [kernel] 0x33
> Nov 19 06:57:11 higiene1 kernel:
> Nov 19 06:57:11 higiene1 kernel:
> Nov 19 06:57:11 higiene1 kernel: Code: f3 ab 8b 16 85 d2 74 0e 31 d2 89 d8 e8 f5 ba 00 00 eb
> 39 8d
>
> ----------------------------------------------------------------------------------
>
> Nov 22 23:41:08 higiene1 kernel:  ------------[ cut here ]------------
> Nov 22 23:41:08 higiene1 kernel: kernel BUG at page_alloc.c:226!
> Nov 22 23:41:08 higiene1 kernel: invalid operand: 0000
> Nov 22 23:41:08 higiene1 kernel: autofs dmfe ide-cd cdrom usb-uhci usbcore ext3 jbd
> Nov 22 23:41:08 higiene1 kernel: CPU:    0
> Nov 22 23:41:08 higiene1 kernel: EIP:    0010:[<c013144a>]    Not tainted
> Nov 22 23:41:08 higiene1 kernel: EFLAGS: 00010086
> Nov 22 23:41:08 higiene1 kernel:
> Nov 22 23:41:08 higiene1 kernel: EIP is at rmqueue [kernel] 0x8a (2.4.18-5)
> Nov 22 23:41:08 higiene1 kernel: eax: 00000020   ebx: c1000730   ecx: 00000001   edx:
> 0002bce5
> Nov 22 23:41:08 higiene1 kernel: esi: c1000730   edi: c02c729c   ebp: 00000005   esp:
> cc177e34
> Nov 22 23:41:08 higiene1 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 22 23:41:08 higiene1 kernel: Process qmail-scanner-q (pid: 13426, stackpage=cc177000)
> Nov 22 23:41:08 higiene1 kernel: Stack: c02251dc 000000e2 00000000 0000b3a6 00000296
> 00000000 c02c7220 c02c7220
> Nov 22 23:41:08 higiene1 kernel:        c02c74f4 00000000 0000061e c01317f5 c15f42e0
> 00000001 c02c74ec 000001d2
> Nov 22 23:41:08 higiene1 kernel:        c1003910 cc336400 00104025 d951e220 c0125f71
> 00000001 d951e220 0810093c
> Nov 22 23:41:08 higiene1 kernel: Call Trace: [<c01317f5>] __alloc_pages [kernel] 0x75
> Nov 22 23:41:08 higiene1 kernel: [<c0125f71>] do_anonymous_page [kernel] 0x51
> Nov 22 23:41:08 higiene1 kernel: [<c0126054>] do_no_page [kernel] 0x34
> Nov 22 23:41:08 higiene1 kernel: [<c01262aa>] handle_mm_fault [kernel] 0xca
> Nov 22 23:41:08 higiene1 kernel: [<c0124ebf>] do_zap_page_range [kernel] 0x18f
> Nov 22 23:41:08 higiene1 kernel: [<c01265c5>] vm_enough_memory [kernel] 0x35
> Nov 22 23:41:08 higiene1 kernel: [<c0113eca>] do_page_fault [kernel] 0x12a
> Nov 22 23:41:08 higiene1 kernel: [<c0127a49>] do_brk [kernel] 0x249
> Nov 22 23:41:08 higiene1 kernel: [<c012779c>] do_munmap [kernel] 0x27c
> Nov 22 23:41:08 higiene1 kernel: [<c0126795>] sys_brk [kernel] 0xc5
> Nov 22 23:41:08 higiene1 kernel: [<c0113da0>] do_page_fault [kernel] 0x0
> Nov 22 23:41:08 higiene1 kernel: [<c0108a04>] error_code [kernel] 0x34
> Nov 22 23:41:08 higiene1 kernel:
> Nov 22 23:41:08 higiene1 kernel:
> Nov 22 23:41:08 higiene1 kernel: Code: 0f 0b 59 58 8b 53 04 8b 03 89 50 04 89 02 8b 44 24 10
> 8b 90
>
> -----------------------------------------------------------------------------
>
> Nov 22 23:42:01 higiene1 kernel:  ------------[ cut here ]------------
> Nov 22 23:42:01 higiene1 kernel: kernel BUG at page_alloc.c:226!
> Nov 22 23:42:01 higiene1 kernel: invalid operand: 0000
> Nov 22 23:42:01 higiene1 kernel: autofs dmfe ide-cd cdrom usb-uhci usbcore ext3 jbd
> Nov 22 23:42:01 higiene1 kernel: CPU:    0
> Nov 22 23:42:01 higiene1 kernel: EIP:    0010:[<c013144a>]    Not tainted
> Nov 22 23:42:01 higiene1 kernel: EFLAGS: 00010096
> Nov 22 23:42:01 higiene1 kernel:
> Nov 22 23:42:01 higiene1 kernel: EIP is at rmqueue [kernel] 0x8a (2.4.18-5)
> Nov 22 23:42:01 higiene1 kernel: eax: 00000020   ebx: c1000730   ecx: 00000001   edx:
> 0002c249
> Nov 22 23:42:01 higiene1 kernel: esi: c1000730   edi: c02c729c   ebp: 00000005   esp:
> cc177e5c
> Nov 22 23:42:01 higiene1 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 22 23:42:01 higiene1 kernel: Process qmail-scanner-q (pid: 13429, stackpage=cc177000)
> Nov 22 23:42:01 higiene1 kernel: Stack: c02251dc 000000e2 00000000 000000b2 00000282
> 00000000 c02c7220 c02c7220
> Nov 22 23:42:01 higiene1 kernel:        c02c74f4 00000000 0000061e c01317f5 d951e220
> 00000001 c02c74ec 000001d2
> Nov 22 23:42:01 higiene1 kernel:        c15eea10 c0129d30 00000001 cc170740 c01260b2
> cc170740 d951e220 080f8ae8
> Nov 22 23:42:01 higiene1 kernel: Call Trace: [<c01317f5>] __alloc_pages [kernel] 0x75
> Nov 22 23:42:01 higiene1 kernel: [<c0129d30>] filemap_nopage [kernel] 0x0
> Nov 22 23:42:01 higiene1 kernel: [<c01260b2>] do_no_page [kernel] 0x92
> Nov 22 23:42:01 higiene1 kernel: [<c01262aa>] handle_mm_fault [kernel] 0xca
> Nov 22 23:42:02 higiene1 kernel: [<c0124ebf>] do_zap_page_range [kernel] 0x18f
> Nov 22 23:42:02 higiene1 kernel: [<c01265c5>] vm_enough_memory [kernel] 0x35
> Nov 22 23:42:02 higiene1 kernel: [<c0113eca>] do_page_fault [kernel] 0x12a
> Nov 22 23:42:02 higiene1 kernel: [<c0127a49>] do_brk [kernel] 0x249
> Nov 22 23:42:02 higiene1 kernel: [<c012779c>] do_munmap [kernel] 0x27c
> Nov 22 23:42:02 higiene1 kernel: [<c0126795>] sys_brk [kernel] 0xc5
> Nov 22 23:42:02 higiene1 kernel: [<c01277e4>] sys_munmap [kernel] 0x34
> Nov 22 23:42:02 higiene1 kernel: [<c0113da0>] do_page_fault [kernel] 0x0
> Nov 22 23:42:02 higiene1 kernel: [<c0108a04>] error_code [kernel] 0x34
> Nov 22 23:42:02 higiene1 kernel:
> Nov 22 23:42:02 higiene1 kernel:
> Nov 22 23:42:02 higiene1 kernel: Code: 0f 0b 59 58 8b 53 04 8b 03 89 50 04 89 02 8b 44 24 10
> 8b 90
>
> ------------------------------------------------------------------------------
>
> Nov 22 23:42:08 higiene1 kernel:  ------------[ cut here ]------------
> Nov 22 23:42:08 higiene1 kernel: kernel BUG at page_alloc.c:226!
> Nov 22 23:42:08 higiene1 kernel: invalid operand: 0000
> Nov 22 23:42:08 higiene1 kernel: autofs dmfe ide-cd cdrom usb-uhci usbcore ext3 jbd
> Nov 22 23:42:08 higiene1 kernel: CPU:    0
> Nov 22 23:42:08 higiene1 kernel: EIP:    0010:[<c013144a>]    Not tainted
> Nov 22 23:42:08 higiene1 kernel: EFLAGS: 00010086
> Nov 22 23:42:08 higiene1 kernel:
> Nov 22 23:42:08 higiene1 kernel: EIP is at rmqueue [kernel] 0x8a (2.4.18-5)
> Nov 22 23:42:08 higiene1 kernel: eax: 00000020   ebx: c1000730   ecx: 00000001   edx:
> 0002c7d3
> Nov 22 23:42:08 higiene1 kernel: esi: c1000730   edi: c02c729c   ebp: 00000005   esp:
> cc177e34
> Nov 22 23:42:08 higiene1 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 22 23:42:08 higiene1 kernel: Process qmail-scanner-q (pid: 13431, stackpage=cc177000)
> Nov 22 23:42:08 higiene1 kernel: Stack: c02251dc 000000e2 00000000 0001c731 00000296
> 00000000 c02c7220 c02c7220
> Nov 22 23:42:08 higiene1 kernel:        c02c74f4 00000000 0000061e c01317f5 c15eedc8
> 00000001 c02c74ec 000001d2
> Nov 22 23:42:08 higiene1 kernel:        c1003910 cc3363fc 00104025 d951e220 c0125f71
> 00000001 d951e220 080ff38c
> Nov 22 23:42:08 higiene1 kernel: Call Trace: [<c01317f5>] __alloc_pages [kernel] 0x75
> Nov 22 23:42:08 higiene1 kernel: [<c0125f71>] do_anonymous_page [kernel] 0x51
> Nov 22 23:42:08 higiene1 kernel: [<c0126054>] do_no_page [kernel] 0x34
> Nov 22 23:42:08 higiene1 kernel: [<c01262aa>] handle_mm_fault [kernel] 0xca
> Nov 22 23:42:08 higiene1 kernel: [<c01265c5>] vm_enough_memory [kernel] 0x35
> Nov 22 23:42:08 higiene1 kernel: [<c0113eca>] do_page_fault [kernel] 0x12a
> Nov 22 23:42:08 higiene1 kernel: [<c0127a49>] do_brk [kernel] 0x249
> Nov 22 23:42:08 higiene1 kernel: [<c012779c>] do_munmap [kernel] 0x27c
> Nov 22 23:42:08 higiene1 kernel: [<c0126795>] sys_brk [kernel] 0xc5
> Nov 22 23:42:08 higiene1 kernel: [<c01277e4>] sys_munmap [kernel] 0x34
> Nov 22 23:42:08 higiene1 kernel: [<c0113da0>] do_page_fault [kernel] 0x0
> Nov 22 23:42:08 higiene1 kernel: [<c0108a04>] error_code [kernel] 0x34
> Nov 22 23:42:08 higiene1 kernel:
> Nov 22 23:42:08 higiene1 kernel:
> Nov 22 23:42:08 higiene1 kernel: Code: 0f 0b 59 58 8b 53 04 8b 03 89 50 04 89 02 8b 44 24 10
> 8b 90
>
> ----------------------------------------------------------------------------
>
> Nov 22 23:48:47 higiene1 kernel:  ------------[ cut here ]------------
> Nov 22 23:48:47 higiene1 kernel: kernel BUG at page_alloc.c:226!
> Nov 22 23:48:47 higiene1 kernel: invalid operand: 0000
> Nov 22 23:48:47 higiene1 kernel: autofs dmfe ide-cd cdrom usb-uhci usbcore ext3 jbd
> Nov 22 23:48:47 higiene1 kernel: CPU:    0
> Nov 22 23:48:47 higiene1 kernel: EIP:    0010:[<c013144a>]    Not tainted
> Nov 22 23:48:47 higiene1 kernel: EFLAGS: 00010086
> Nov 22 23:48:47 higiene1 kernel:
> Nov 22 23:48:47 higiene1 kernel: EIP is at rmqueue [kernel] 0x8a (2.4.18-5)
> Nov 22 23:48:47 higiene1 kernel: eax: 00000020   ebx: c1000730   ecx: 00000001   edx:
> 0002cd2f
> Nov 22 23:48:47 higiene1 kernel: esi: c1000730   edi: c02c729c   ebp: 00000005   esp:
> cc3a7e34
> Nov 22 23:48:47 higiene1 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 22 23:48:47 higiene1 kernel: Process wrapper-qmail-s (pid: 13434, stackpage=cc3a7000)
> Nov 22 23:48:47 higiene1 kernel: Stack: c02251dc 000000e2 00000000 400104b4 00000296
> 00000000 c02c7220 c02c7220
> Nov 22 23:48:47 higiene1 kernel:        c02c74f4 00000000 0000061e c01317f5 c16d7488
> 00000001 c02c74ec 000001d2
> Nov 22 23:48:47 higiene1 kernel:        c1003910 cc335ff8 00104025 d951e0e0 c0125f71
> 00000001 d951e0e0 bfffefbc
> Nov 22 23:48:47 higiene1 kernel: Call Trace: [<c01317f5>] __alloc_pages [kernel] 0x75
> Nov 22 23:48:47 higiene1 kernel: [<c0125f71>] do_anonymous_page [kernel] 0x51
> Nov 22 23:48:47 higiene1 kernel: [<c0126054>] do_no_page [kernel] 0x34
> Nov 22 23:48:47 higiene1 kernel: [<c01262aa>] handle_mm_fault [kernel] 0xca
> Nov 22 23:48:47 higiene1 kernel: [<c012723b>] expand_stack [kernel] 0x2b
> Nov 22 23:48:47 higiene1 kernel: [<c0113eca>] do_page_fault [kernel] 0x12a
> Nov 22 23:48:47 higiene1 kernel: [<c0142eb1>] open_namei [kernel] 0x4b1
> Nov 22 23:48:47 higiene1 kernel: [<c01416be>] getname [kernel] 0x5e
> Nov 22 23:48:47 higiene1 kernel: [<c0138096>] filp_open [kernel] 0x36
> Nov 22 23:48:47 higiene1 kernel: [<c01416be>] getname [kernel] 0x5e
> Nov 22 23:48:47 higiene1 kernel: [<c0113da0>] do_page_fault [kernel] 0x0
> Nov 22 23:48:47 higiene1 kernel: [<c0108a04>] error_code [kernel] 0x34
> Nov 22 23:48:47 higiene1 kernel:
> Nov 22 23:48:47 higiene1 kernel:
> Nov 22 23:48:47 higiene1 kernel: Code: 0f 0b 59 58 8b 53 04 8b 03 89 50 04 89 02 8b 44 24 10
> 8b 90
>
> ---------------------------------------------------------------------------
>
> Nov 28 19:15:07 higiene1 kernel: Unable to handle kernel paging request at virtual address
> 339ee96d
> Nov 28 19:15:07 higiene1 kernel:  printing eip:
> Nov 28 19:15:07 higiene1 kernel: c0128b78
> Nov 28 19:15:07 higiene1 kernel: *pde = 00000000
> Nov 28 19:15:07 higiene1 kernel: Oops: 0000
> Nov 28 19:15:07 higiene1 kernel: autofs dmfe ide-cd cdrom usb-uhci usbcore ext3 jbd
> Nov 28 19:15:07 higiene1 kernel: CPU:    0
> Nov 28 19:15:07 higiene1 kernel: EIP:    0010:[<c0128b78>]    Not tainted
> Nov 28 19:15:07 higiene1 kernel: EFLAGS: 00010206
> Nov 28 19:15:07 higiene1 kernel:
> Nov 28 19:15:07 higiene1 kernel: EIP is at __find_lock_page_helper [kernel] 0x28 (2.4.18-5)
> Nov 28 19:15:07 higiene1 kernel: eax: 00000000   ebx: 339ee965   ecx: c1364c38   edx:
> 0000055d
> Nov 28 19:15:07 higiene1 kernel: esi: 0000055d   edi: dad48514   ebp: c1364c38   esp:
> c5e71ee0
> Nov 28 19:15:07 higiene1 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 28 19:15:07 higiene1 kernel: Process qmail-scanner-q (pid: 25377, stackpage=c5e71000)
> Nov 28 19:15:07 higiene1 kernel: Stack: 0000055d 0000055d c17a8eb0 40014000 c012b2e0
> dad48514 0000055d c17a8eb0
> Nov 28 19:15:07 higiene1 kernel:        c5e71f34 dcbd3980 c5e70000 00000001 00000000
> 0000055d 00001000 fffffff4
> Nov 28 19:15:07 higiene1 kernel:        00000000 0055d000 00000000 dad48460 dad48514
> 00000000 c46a81e0 c5e71f5c
> Nov 28 19:15:07 higiene1 kernel: Call Trace: [<c012b2e0>] generic_file_write [kernel] 0x420
> Nov 28 19:15:07 higiene1 kernel: [<c0114e39>] __wake_up [kernel] 0x39
> Nov 28 19:15:07 higiene1 kernel: [<e081cba2>] ext3_file_write [ext3] 0x22
> Nov 28 19:15:07 higiene1 kernel: [<c01389d6>] sys_write [kernel] 0x96
> Nov 28 19:15:07 higiene1 kernel: [<c0109de8>] do_IRQ [kernel] 0x68
> Nov 28 19:15:07 higiene1 kernel: [<c0109e0c>] do_IRQ [kernel] 0x8c
> Nov 28 19:15:07 higiene1 kernel: [<c0108913>] system_call [kernel] 0x33
> Nov 28 19:15:07 higiene1 kernel:
> Nov 28 19:15:07 higiene1 kernel:
> Nov 28 19:15:07 higiene1 kernel: Code: 39 7b 08 75 f4 39 73 0c 75 ef 85 db 74 32 ff 43 14 31
> c0 0f
>
> -------------------------------------------------------------------------------
>
> Nov 29 04:02:57 higiene1 kernel: Unable to handle kernel paging request at virtual address
> fa1cb206
> Nov 29 04:02:57 higiene1 kernel:  printing eip:
> Nov 29 04:02:57 higiene1 kernel: c0130078
> Nov 29 04:02:57 higiene1 kernel: *pde = 00000000
> Nov 29 04:02:57 higiene1 kernel: Oops: 0002
> Nov 29 04:02:57 higiene1 kernel: autofs dmfe ide-cd cdrom usb-uhci usbcore ext3 jbd
> Nov 29 04:02:57 higiene1 kernel: CPU:    0
> Nov 29 04:02:57 higiene1 kernel: EIP:    0010:[<c0130078>]    Not tainted
> Nov 29 04:02:57 higiene1 kernel: EFLAGS: 00010282
> Nov 29 04:02:57 higiene1 kernel:
> Nov 29 04:02:57 higiene1 kernel: EIP is at refill_inactive_zone [kernel] 0x1c8 (2.4.18-5)
> Nov 29 04:02:57 higiene1 kernel: eax: c02c7248   ebx: c0224840   ecx: cde94000   edx:
> fa1cb206
> Nov 29 04:02:57 higiene1 kernel: esi: c10006dc   edi: 00000010   ebp: c02c7220   esp:
> c1775fb0
> Nov 29 04:02:57 higiene1 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 29 04:02:57 higiene1 kernel: Process kswapd (pid: 5, stackpage=c1775000)
> Nov 29 04:02:57 higiene1 kernel: Stack: c02c7248 00000000 00000069 00000011 00000475
> c02c7220 00000069 00000000
> Nov 29 04:02:57 higiene1 kernel:        c0130ab0 c02c7220 00000006 00000000 00010f00
> c1719fb8 c0105000 0008e000
> Nov 29 04:02:57 higiene1 kernel:        c0107136 00000000 c0130830 c02dffdc
> Nov 29 04:02:57 higiene1 kernel: Call Trace: [<c0130ab0>] kswapd [kernel] 0x280
> Nov 29 04:02:57 higiene1 kernel: [<c0105000>] stext [kernel] 0x0
> Nov 29 04:02:57 higiene1 kernel: [<c0107136>] kernel_thread [kernel] 0x26
> Nov 29 04:02:57 higiene1 kernel: [<c0130830>] kswapd [kernel] 0x0
> Nov 29 04:02:57 higiene1 kernel:
> Nov 29 04:02:57 higiene1 kernel:
> Nov 29 04:02:57 higiene1 kernel: Code: 89 02 ff 0d 20 55 33 c0 e9 4d 01 00 00 0f ab 56 fc 19
> c0 85
>
> --------------------------------------------------------------------------------

