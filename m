Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267164AbTAPQXO>; Thu, 16 Jan 2003 11:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTAPQXO>; Thu, 16 Jan 2003 11:23:14 -0500
Received: from borg.org ([208.218.135.231]:4790 "HELO borg.org")
	by vger.kernel.org with SMTP id <S267164AbTAPQXN>;
	Thu, 16 Jan 2003 11:23:13 -0500
Date: Thu, 16 Jan 2003 11:32:09 -0500
From: Kent Borg <kentborg@borg.org>
To: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any brand recomendation for a linux laptop ?
Message-ID: <20030116113209.B22370@borg.org>
References: <200301161100.45552.Nicolas.Turro@sophia.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301161100.45552.Nicolas.Turro@sophia.inria.fr>; from Nicolas.Turro@sophia.inria.fr on Thu, Jan 16, 2003 at 11:00:45AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 11:00:45AM +0100, Nicolas Turro wrote:
> I am software engineer at a french research institute, in charge of
> the linux support on about 600 computers. I am looking for laptops
> whith linux support/certification. I couln't find any recent laptop
> model on your certification page.

Linux is still too obscure for a good certification list.  (Have
heart, the internet was once obscure too...)

> Would you recomend me any brand of computer ?

Download the Knoppix CD (knoppix.com).  It is a bootable Linux that
runs from CD and is quite usable.  It is based on Debian.  Bring the
to your local omputer store and try booting different models with the
CD and see which ones work.  That will give you one data point on how
Linux compatible the computer it.

> - - sound is hard or impossible to setup correctly.

I have an MSI motherboard-based computer at home on which Red Hat
couldn't make the sound work until 8.0--but the Knoppix CD has managed
sound on that machine just fine.

Knoppix is also a *great* rescue CD--and a nice way to temporarily
turn a groady MS Windows into a decent Linux machine.

> Any help/advice would be apreciated.

Laptops are just like big office computers, except they are more
expensive, less compatible, less powerful, easier to steal and fence,
and smaller.  Um, clearly "smaller" is the feature here.  Unless you
really expect to only use it on two different desks and move it
seldomly between them, I say go for small.  There is a world of
difference between a computer that weighs under 2 kg and one that is
over 3.5 kg.  Go for small and you can bring it with you on spec.
Given builtin ethernet and wireless, the need for floppies or CDs is
much less.  I have an old Sony Z505LE with no CD drive at all.  I have
done Linux installs with an external USB floppy and an NFS copy of the
distribution.  I have no regrets that I didn't spent $300 extra for
Sony's CD.

Also battery life is important.  And what do extra batteries cost?  My
original "single capacity" battery is worn out.  It can keep my
computer in suspension while I commute, but can't really use it.  And
replacements are really expensive.  I wish the Apple Ibook were x86...


-kb, the Kent whose current evening project is to remaster Knoppix
with tripwire added and use that plus a locked floppy as a trustworthy
intrusion detector.
