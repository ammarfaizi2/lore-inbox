Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbTBCScx>; Mon, 3 Feb 2003 13:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbTBCScx>; Mon, 3 Feb 2003 13:32:53 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:12773 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S266961AbTBCScw>; Mon, 3 Feb 2003 13:32:52 -0500
Date: Mon, 3 Feb 2003 10:42:04 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: system call documentation
Message-ID: <20030203184204.GB19502@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <UTC200302011305.h11D5Jg24212.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200302011305.h11D5Jg24212.aeb@smtp.cwi.nl>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_hugepages and free_hugepages no longer exist.
	--Mark

On Sat, Feb 01, 2003 at 02:05:19PM +0100, Andries.Brouwer@cwi.nl wrote:
> Preparing the next man page release, I compared the list of
> system calls for i386 in 2.4.20 with the list of documented
> system calls. It looks like
> 
> alloc_hugepages,
> exit_group,
> fgetxattr,
> flistxattr,
> free_hugepages,
> fremovexattr,
> fsetxattr,
> getpmsg,
> get_thread_area,
> gettid,
> getxattr,
> io_cancel,
> io_destroy,
> io_getevents,
> io_setup,
> io_submit,
> lgetxattr,
> listxattr,
> llistxattr,
> lremovexattr,
> lsetxattr,
> madvise1,
> putpmsg,
> readahead,
> removexattr,
> rt_sigaction,
> rt_sigpending,
> rt_sigprocmask,
> rt_sigqueueinfo,
> rt_sigreturn,
> rt_sigsuspend,
> rt_sigtimedwait,
> security,
> set_thread_area,
> setxattr,
> tkill,
> ugetrlimit
> 
> are undocumented so far. Contributed man pages are welcome.
> 
> Andries
> aeb@cwi.nl
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
Mark Fasheh
Software Developer, Oracle Corp
mark.fasheh@oracle.com
