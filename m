Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265423AbUATMhI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 07:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbUATMhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 07:37:08 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:2900 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265423AbUATMhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 07:37:06 -0500
From: Bart Samwel <bart@samwel.tk>
To: Tommi Virtanen <tv@tv.debian.net>,
       Lorenzo Hernandez Garcia-Hierro <lorenzohgh@nsrg-security.com>
Subject: Re: Noise with  2.6.0 in a Dell Laptop ( Latitude c600 )
Date: Tue, 20 Jan 2004 13:36:53 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <1073488405.850.35.camel@zeus> <4003F998.4020104@tv.debian.net>
In-Reply-To: <4003F998.4020104@tv.debian.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401201336.54113.bart@samwel.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 January 2004 14:58, Tommi Virtanen wrote:
> Lorenzo Hernandez Garcia-Hierro wrote:
> > When the 2.6.0 inits in my laptop it becomes reaaallyyy noisy.
> > Why ?
>
> If it's the fans, it's the BIOS reading CPU temperature of 85 C,
> which is not true. It seems a Fn-Z press resets this reading to
> sane values. You can look at the temperature reading and fan
> state with i8kutils.
>
> Atleast that's what a Dell Latitude C640 that I had did.

Might it be that the hardware reports 85 F instead of 85 C maybe? That's about 
(85-32)*0.55 = about 29 C, which may be more realistic when you're just 
booting it up. :)

-- Bart
