Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132156AbQL1BTM>; Wed, 27 Dec 2000 20:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132236AbQL1BTC>; Wed, 27 Dec 2000 20:19:02 -0500
Received: from the-penguin.otak.com ([216.122.56.136]:10112 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S132156AbQL1BSw>; Wed, 27 Dec 2000 20:18:52 -0500
Date: Wed, 27 Dec 2000 16:50:43 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oops 2.4.0 pre3
Message-ID: <20001227165043.A669@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.0-test13-pre3 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was doing nothing out of the ordinary wen my system froze.
Here is the oops
Yes that is the correct system map btw.
If anyone needs anything more please ask.

ksymoops 2.3.4 on i686 2.4.0-test13-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test13-pre3/ (default)
     -m /boot/System.map-2.4.0-test13-pre3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(pm_active) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(pm_find) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(pm_register) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(pm_send) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(pm_send_all) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(pm_unregister) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(pm_unregister_all) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_clear_event_R__ver_acpi_clear_event not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_cm_memcpy_R__ver_acpi_cm_memcpy not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_cm_memset_R__ver_acpi_cm_memset not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_cm_strncmp_R__ver_acpi_cm_strncmp not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_dbg_layer_R__ver_acpi_dbg_layer not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_dbg_level_R__ver_acpi_dbg_level not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_disable_event_R__ver_acpi_disable_event not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_enable_event_R__ver_acpi_enable_event not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_evaluate_object_R__ver_acpi_evaluate_object not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_current_resources_R__ver_acpi_get_current_resources not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_handle_R__ver_acpi_get_handle not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_name_R__ver_acpi_get_name not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_next_object_R__ver_acpi_get_next_object not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_object_info_R__ver_acpi_get_object_info not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_parent_R__ver_acpi_get_parent not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_possible_resources_R__ver_acpi_get_possible_resources not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_processor_cx_info_R__ver_acpi_get_processor_cx_info not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_processor_throttling_info_R__ver_acpi_get_processor_throttling_info not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_processor_throttling_state_R__ver_acpi_get_processor_throttling_state not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_get_type_R__ver_acpi_get_type not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_install_address_space_handler_R__ver_acpi_install_address_space_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_install_gpe_handler_R__ver_acpi_install_gpe_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_install_notify_handler_R__ver_acpi_install_notify_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_breakpoint_R__ver_acpi_os_breakpoint not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_callocate_R__ver_acpi_os_callocate not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_free_R__ver_acpi_os_free not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_in8_R__ver_acpi_os_in8 not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_out8_R__ver_acpi_os_out8 not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_printf_R__ver_acpi_os_printf not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_queue_for_execution_R__ver_acpi_os_queue_for_execution not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_sleep_R__ver_acpi_os_sleep not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_os_sleep_usec_R__ver_acpi_os_sleep_usec not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_processor_sleep_R__ver_acpi_processor_sleep not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_remove_address_space_handler_R__ver_acpi_remove_address_space_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_remove_gpe_handler_R__ver_acpi_remove_gpe_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_remove_notify_handler_R__ver_acpi_remove_notify_handler not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_set_current_resources_R__ver_acpi_set_current_resources not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_set_processor_sleep_state_R__ver_acpi_set_processor_sleep_state not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_set_processor_throttling_state_R__ver_acpi_set_processor_throttling_state not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol debug_print_prefix_R__ver_debug_print_prefix not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol debug_print_raw_R__ver_debug_print_raw not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_exit_R__ver_function_exit not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_status_exit_R__ver_function_status_exit not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_trace_R__ver_function_trace not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol function_value_exit_R__ver_function_value_exit not found in System.map.  Ignoring ksyms_base entry
Dec 27 15:56:09 the-penguin kernel: invalid operand: 0000
Dec 27 15:56:09 the-penguin kernel: CPU:    0
Dec 27 15:56:09 the-penguin kernel: EIP:    0010:[page_launder+1993/2160]
Dec 27 15:56:09 the-penguin kernel: EFLAGS: 00210282
Dec 27 15:56:09 the-penguin kernel: eax: 0000001c   ebx: c1331ee0   ecx: c02384a8   edx: 00000000
Dec 27 15:56:09 the-penguin kernel: esi: c1331efc   edi: 00000004   ebp: 00000000   esp: c167ff90
Dec 27 15:56:09 the-penguin kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 15:56:09 the-penguin kernel: Process kswapd (pid: 3, stackpage=c167f000)
Dec 27 15:56:09 the-penguin kernel: Stack: c01fa6a5 c01fa864 000002da 00010f00 00000004 00000000 00000000 00000004 
Dec 27 15:56:09 the-penguin kernel:        00000000 00000045 00000187 00000000 c012a464 00000004 00000000 00010f00 
Dec 27 15:56:09 the-penguin kernel:        c01fa9d7 c167e239 0008e000 c012a53c 00000004 00000000 d7feffb8 00000000 
Dec 27 15:56:09 the-penguin kernel: Call Trace: [tvecs+8189/70756] [tvecs+8636/70756] [do_try_to_free_pages+52/144] [tvecs+9007/70756] [kswapd+124/288] [kernel_thread+40/64] 
Dec 27 15:56:09 the-penguin kernel: Code: 0f 0b 83 c4 0c 89 f6 8d 73 28 8d 43 2c 39 43 2c 74 11 b9 01 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   89 f6                     mov    %esi,%esi
Code;  00000007 Before first symbol
   7:   8d 73 28                  lea    0x28(%ebx),%esi
Code;  0000000a Before first symbol
   a:   8d 43 2c                  lea    0x2c(%ebx),%eax
Code;  0000000d Before first symbol
   d:   39 43 2c                  cmp    %eax,0x2c(%ebx)
Code;  00000010 Before first symbol
  10:   74 11                     je     23 <_EIP+0x23> 00000023 Before first symbol
Code;  00000012 Before first symbol
  12:   b9 01 00 00 00            mov    $0x1,%ecx


53 warnings issued.  Results may not be reliable.

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux the-penguin 2.4.0-test13-pre3 #1 Fri Dec 22 07:35:54 PST 2000 i686 unknown
Kernel modules         2.3.23
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0i
Modules Loaded         nls_cp437 nls_iso8859-1 msdos fat ipx agpgart emu10k1 soundcore 3c59x


-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
