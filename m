Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbUJZQAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbUJZQAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 12:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbUJZQAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 12:00:39 -0400
Received: from siaag1aa.compuserve.com ([149.174.40.3]:18331 "EHLO
	siaag1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261274AbUJZP52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:57:28 -0400
Date: Tue, 26 Oct 2004 11:54:48 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: My thoughts on the "new development model"
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Bill Davidsen <davidsen@tmr.com>
Message-ID: <200410261156_MC3-1-8D2C-C64D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 at 07:28:41 -0700  William Lee Irwin III wrote:
> On Tue, Oct 26, 2004 at 06:44:46AM -0400, Ed Tomlinson wrote:
>> To my mind this just points out the need for a bug fix branch.   e.g. a
>> branch containing just bug/security fixes against the current stable
>> kernel.  It might also be worth keeping the branch active for the n-1
>> stable kernel too.
>> PS.  we could call this the Bug/Security or bs kernels.
>
> This has been very explicitly encouraged numerous times and no one has
> taken up the task. Someone actually doing something about this for once
> may be helpful to quell the worries of people such as we're hearing from.


  I'm running a kernel I call 2.6.9.1 right now, but I have no clue how to
distribute it.  How do you get an account on kernel.org?


 Directory of t:\in\269\2691

24-10-04  21:45         <DIR>          .
25-10-04  13:48         <DIR>          ..
24-10-04  21:59                  2,647 000-MANIFEST
24-10-04  21:50                  1,146 3c59x_pci_disable_device.patch
23-10-04  19:11                  1,046 ac3_compiler.h_assembly.patch
23-10-04  19:47                  1,295 ac3_config_via_velocity.patch
23-10-04  19:37                  1,056 ac3_cpia_fixes.patch
24-10-04  22:28                  2,652 ac3_i8042.patch
23-10-04  19:47                    571 ac3_i8xx_tco_timer.patch
23-10-04  19:47                    907 ac3_moxa_wakeup.patch
23-10-04  23:05                  1,942 ac3_ppp_hangup.patch
23-10-04  19:43                    964 ac3_skbuff_tso.patch
23-10-04  19:43                    946 ac3_smbfs_request.patch
23-10-04  19:42                 17,977 ac3_vm_io.patch
23-10-04  14:18                    961 compat_ioctl_tiocsbrk.patch
24-10-04  19:44                    329 decnet_connrefused.patch
23-10-04  21:08                  2,218 delay_rq_lock.patch
23-10-04  13:20                    491 dm_duplicate_kfree.patch
24-10-04  20:34                  5,667 exec_timers_and_signals.patch
23-10-04  20:23                    718 hvsi_oops.patch
23-10-04  13:53                  1,552 i2c_amd_kconfig.patch
24-10-04  19:59                  1,164 ide_no_chs.patch
23-10-04  21:22                    483 init_poison.patch
23-10-04  13:42                  1,190 ioapic_init_section.patch
24-10-04  21:48                  1,670 ioapic_on_nvidia_boards.patch
23-10-04  13:43                    855 log_buf_shift.patch
23-10-04  21:54                    737 maxtor_ide_probe.patch
19-10-04  22:10                    820 memset_signal_ppc64.patch
23-10-04  22:51                    873 netif_rx_ni_preempt_safe.patch
23-10-04  14:08                  1,203 o_direct_mmapped_io.patch
23-10-04  22:27                  4,181 parport_superio.patch
23-10-04  13:28                    662 pcdp_swap_args.patch
23-10-04  22:48                    910 pci_dev_put.patch
23-10-04  13:32                  1,593 percpu_alignment.patch
23-10-04  20:38                    786 proc_wrong_parent.patch
23-10-04  14:09                  1,542 quoted_env_vars_3.patch
23-10-04  22:24                    608 return_enfile_not_emfile.patch
23-10-04  22:26                  1,453 s390_sacf_exception.patch
23-10-04  14:20                  1,519 suspend_time_adjust.patch
23-10-04  13:50                    636 tcp_output_skbuff_fix.patch
23-10-04  13:51                  3,375 unbalanced_tasks_v3.patch
23-10-04  13:56                    957 usr_courier_pnp_id.patch
24-10-04  21:48                  2,051 vga_console_font.patch
23-10-04  22:28                    950 vm_dirty_ratio_clamp.patch
24-10-04  19:34                    822 vm_pages_scanned_active_list.patch
23-10-04  13:37                    840 x86_64_syscall32_initdata.patch
              44 File(s)         76,965 bytes



--Chuck Ebbert  26-Oct-04  11:52:08
