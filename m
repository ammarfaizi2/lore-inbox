Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280810AbRKOMd0>; Thu, 15 Nov 2001 07:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280815AbRKOMdQ>; Thu, 15 Nov 2001 07:33:16 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:21121 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S280810AbRKOMdN>; Thu, 15 Nov 2001 07:33:13 -0500
Message-ID: <3BF3B608.EDBF4022@randomlogic.com>
Date: Thu, 15 Nov 2001 04:33:12 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [OT] Athlon SMP blues - SOLVED by gpm
In-Reply-To: <Pine.GSO.4.33.0111151041080.14971-100000@gurney>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the saying goes, "It's probably some little thing."

It's always the little things that seem to bit you the hardest and where
it most hurts. :)

PGA

Alastair Stevens wrote:
> 
> > > I installed Red Hat 7.2 and the machine boots fine, using SMP or UP
> > > kernels (Red Hat 2.4.9-7), but totally HANGS at the login prompt. Can't
> > > type, can't reboot, can't do anything. Single user mode _does_ let me
> > > in, however, and this is the only progress so far.
> >
> > Try plugging in a mouse or stop running gpm.
> 
> YES YES YES!!! This was it! After 24 hours of building 17 different
> kernels, checking out every inch of my hardware, and trying to build
> ramdisk images, it was the humble 'gpm' that caused my headaches!
> There's no mouse on the machine. Thanks very much indeed, and boy have I
> learned something now....
> 
> PS - thanks to all who sent in lots of ideas on this problem! It
> actually turns out the machine is *not* overheating at all. The 76C BIOS
> CPU temperature was erroneous, and in fact it's more like 42C now, which
> is perfectly healthy of course ;-)
> 
> Cheers
> Alastair
> 

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
