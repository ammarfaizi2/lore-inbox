Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbTBAMzx>; Sat, 1 Feb 2003 07:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTBAMzx>; Sat, 1 Feb 2003 07:55:53 -0500
Received: from hera.cwi.nl ([192.16.191.8]:12966 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264822AbTBAMzw>;
	Sat, 1 Feb 2003 07:55:52 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 1 Feb 2003 14:05:19 +0100 (MET)
Message-Id: <UTC200302011305.h11D5Jg24212.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: system call documentation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Preparing the next man page release, I compared the list of
system calls for i386 in 2.4.20 with the list of documented
system calls. It looks like

alloc_hugepages,
exit_group,
fgetxattr,
flistxattr,
free_hugepages,
fremovexattr,
fsetxattr,
getpmsg,
get_thread_area,
gettid,
getxattr,
io_cancel,
io_destroy,
io_getevents,
io_setup,
io_submit,
lgetxattr,
listxattr,
llistxattr,
lremovexattr,
lsetxattr,
madvise1,
putpmsg,
readahead,
removexattr,
rt_sigaction,
rt_sigpending,
rt_sigprocmask,
rt_sigqueueinfo,
rt_sigreturn,
rt_sigsuspend,
rt_sigtimedwait,
security,
set_thread_area,
setxattr,
tkill,
ugetrlimit

are undocumented so far. Contributed man pages are welcome.

Andries
aeb@cwi.nl
