Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbRCWOOt>; Fri, 23 Mar 2001 09:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130834AbRCWOOj>; Fri, 23 Mar 2001 09:14:39 -0500
Received: from athena.intergrafix.net ([206.245.154.69]:7642 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S130831AbRCWOOd>; Fri, 23 Mar 2001 09:14:33 -0500
Date: Fri, 23 Mar 2001 09:13:52 -0500 (EST)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2-ac21 
In-Reply-To: <6054.985313778@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.10.10103230910390.27532-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >It was causing SMP boxes to crash mysteriously after
> >several hours or days.  Quite a lot of them.  Nobody
> >was able to explain why, so it was turned off.
> 
> I know why it was turned off by default.  The annoying this is that now
> the *only* way to activate the watchdog is via a boot command.  It is
> not possible to compile a standard debugging kernel with this option
> turned on, you have to rely on every user setting the boot options for
> every kernel.  If it is going to be off by default there should be a
> way to patch the kernel to make it on by default.
> 

i'm troubled by that fact that something the would be used to debug the
kernel, is something that actually causes crashes. doesn't that kind of
defeat the purpose..and introduce just another unstable element to the
problem/crash at hand?

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

