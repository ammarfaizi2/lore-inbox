Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291081AbSBRTZN>; Mon, 18 Feb 2002 14:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291021AbSBRSid>; Mon, 18 Feb 2002 13:38:33 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:2565 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S290157AbSBRS33>;
	Mon, 18 Feb 2002 13:29:29 -0500
Date: Sun, 17 Feb 2002 13:45:29 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-mjc2
Message-ID: <20020217134529.A36@toy.ucw.cz>
In-Reply-To: <20020214114335.GA4058@merlin.emma.line.org> <E16bL89-0008Jl-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16bL89-0008Jl-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 14, 2002 at 12:36:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hum, the last time I merged that stuff into my own kernel, the
> > patch-generator that they ship did not include all of the drivers I
> > needed. Also, I'm missing i2c from your patch list. Is that intentional
> > or is the i2c patch not needed? Which lm_sensors version did you merge?
> 
> Be very careful merging lm_sensors. Incorrect use of it is a wonderful
> way to do things like totally destroy (back to factory) an ibm thinkpad.
> Thats why I've always stayed clear of it

They deserve it! Shipping hardware that commits suicide on i2o access is 
bad thing (tm).
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

