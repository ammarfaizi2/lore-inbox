Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285048AbRLUTRe>; Fri, 21 Dec 2001 14:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285007AbRLUTPo>; Fri, 21 Dec 2001 14:15:44 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:57101 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S285030AbRLUTPg>;
	Fri, 21 Dec 2001 14:15:36 -0500
Date: Tue, 18 Dec 2001 01:27:56 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: root@chaos.analogic.com, Thomas Capricelli <orzel@kde.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently
Message-ID: <20011218012755.C37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.3.95.1011213142534.1037A-100000@chaos.analogic.com> <08d701c18412/mnt/tmp/sendmee91d2c0601010a@prefect>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <08d701c18412/mnt/tmp/sendmee91d2c0601010a@prefect>; from brad@ltc.com on Thu, Dec 13, 2001 at 03:09:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> > There are many arguments, but I don't think power consumption is
> > one of them. Whatever they use for RAM on the palm machines allows
> > the machines to run a week on 4 'aa' -size batteries. Maybe they
> > grab kinetic energy from keystrokes using flea-generators ^;).
> 
> No flea-generators that I know of.  :-)
> 
> SDRAM, even in self-refresh mode, does draw considerable current.  But then
> again so does decompressing stuff from ROM all the time.

Well.. at least decompressing from rom does not eat power when not doing
*something*.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

