Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbTDJVJ2 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTDJVJ2 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:09:28 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:6849 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264189AbTDJVJZ (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 17:09:25 -0400
To: Dan Kegel <dank@kegel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: gcc-2.95 broken on PPC? 
X-Mailer: exmh version 2.2
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-reply-to: Your message of "Thu, 10 Apr 2003 10:52:15 PDT."
             <3E95AF4F.20105@kegel.com> 
Date: Thu, 10 Apr 2003 23:20:50 +0200
Message-Id: <20030410212055.B6A18C5877@atlas.denx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E95AF4F.20105@kegel.com> you wrote:
> The Denkster wrote:
>
> > This is speculation only. We use gcc-2.95.4 as part of  our  ELDK  in
> > all  of our projects, and a lot of people are using these tools, too.
> > We definitely see more problems with gcc-3.x compilers.
> 
> Hi Wolfgang, when you say you see more problems with gcc-3.x
> compilers, what is x?  I'd understand if you saw problems

There were serios problems with 3.0. I never tested 3.1.  I  believed
3.2  was OK, but I every now and then problems pop up that seem to be
compiler related. Never found time to investigate, though.

> with gcc-3.0.*, but I had hoped that gcc-3.2.2 would compile
> good kernels for ppc.
> (Me, I'm still using Montavista Linux 2.0's gcc-2.95.3 to build my ppc kernels,
> but am looking for an excuse to switch to gcc-3.2.* or gcc-3.3.*.)

I just heard that gdb 5.2.1 shows some problems when built  with  gcc
3.2  as  sipped with RH-8.0, and the problem goes away when compiling
with 2.95.[34]. The information might be wrong  or  a  misinterpreta-
tion, but I'm still suspicious.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Why is an average signature file longer than an average Perl script??
