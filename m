Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290741AbSARQ4e>; Fri, 18 Jan 2002 11:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290739AbSARQyo>; Fri, 18 Jan 2002 11:54:44 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:24843 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290741AbSARQrG>;
	Fri, 18 Jan 2002 11:47:06 -0500
Date: Mon, 14 Jan 2002 02:46:03 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rob Landley <landley@trommello.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114024602.C2157@toy.ucw.cz>
In-Reply-To: <200201101753.g0AHrlA17591@snark.thyrsus.com> <E16OkSV-0005EZ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16OkSV-0005EZ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 10, 2002 at 07:01:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > exhausted...)  What sound output device DOESN'T have this much cache?  (You 
> > mentioned USB speakers in your diary at one point, which seemed to be like 
> > those old "paralell port cable plus a few resistors equals sound output" 
> > hacks...)
> 
> Umm no USB audio is rather good. USB sends isosynchronous, time guaranteed
> sample streams down the USB bus, to the speakers where the A to D is clear
> of the machine proper.

Actually usb speakers are *very* sensitive to latency, and when they drop
out,they drop out for half a second...
									Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

