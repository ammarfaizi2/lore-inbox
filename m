Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbQKMQKE>; Mon, 13 Nov 2000 11:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbQKMQJy>; Mon, 13 Nov 2000 11:09:54 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:522 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129211AbQKMQJf>; Mon, 13 Nov 2000 11:09:35 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDCCD@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: Steven_Snyder@3com.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: State of Posix compliance in v2.2/v2.4 kernel?
Date: Mon, 13 Nov 2000 08:09:19 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Steven_Snyder@3com.com wrote:
> > Sorry if this is a FAQ, but I've searched the archives for this list
> > (http://www.uwsg.iu.edu/hypermail/linux/kernel/) and only 
> come with references
> > from 1996!
> > 
> > What is the state of Posix-compliant services (threads, 
> semaphores, timers,
> > etc.) in the current (v2.2/v2.4) Linux kernels?
> 
> IMHO this is a question better asked of glibc people, not 
> kernel people.
> 
> The kernel does its best to facilitate POSIX compliances, but in some
> cases the kernel developers have said "POSIX is braindead here!" and
> solved a particular problem in a non-POSIX way.  [and leaves glibc to
> pick up the pieces, and enforce POSIX compliancy]
> 
> Also, from what I've seen lately on IRC and lkml, the Single Unix
> Specification ("SuS") is generally held in higher regard than 
> POSIX; and
> when spec questions arise, kernel developers tend to check SuS before
> POSIX (if POSIX is checked at all).
> 
> 	Jeff

and there's some useful info about libc, threads, etc.,
at the Linux Standard Base CVS (http://www.linuxbase.org/
plus its sf.net project page + CVS links).

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
