Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbTAII7p>; Thu, 9 Jan 2003 03:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbTAII7o>; Thu, 9 Jan 2003 03:59:44 -0500
Received: from hacksaw.org ([216.41.5.170]:24543 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S261973AbTAII7o>; Thu, 9 Jan 2003 03:59:44 -0500
Message-Id: <200301090908.h09986W6008976@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.5 08/15/2002 with nmh-1.0.4
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: OT Naming. was: Re: Why is Nvidia given GPL'd code to use in 
 closed source drivers?
In-reply-to: Your message of "08 Jan 2003 13:09:14 +0100."
             <yw1xn0mbn8r9.fsf@gladiusit.e.kth.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Jan 2003 04:08:06 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The functions in glibc that you are referring to are specified by
>ANSI/ISO C and POSIX standards.  If a system doesn't comply to these
>i

It's a POSIX conforming API, but the ABI is provided by linking against glibc. 
It's unlikely that you could easily sub in a new libc easily, especially if 
the program makes use of any GNU extensions.

-- 
When we have nothing to say, it is very hard to say nothing.
When we have nothing to do, it is very hard to do nothing.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


