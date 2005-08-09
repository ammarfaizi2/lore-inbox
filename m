Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVHIOSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVHIOSw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVHIOSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:18:51 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:42653 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S932551AbVHIOSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:18:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Wireless support
Date: Tue, 9 Aug 2005 16:24:16 +0200
User-Agent: KMail/1.8.2
Cc: Jochen Friedrich <jochen@scram.de>, Adrian Bunk <bunk@stusta.de>,
       Lee Revell <rlrevell@joe-job.com>, abonilla@linuxwireless.org,
       "'Andreas Steinmetz'" <ast@domdv.de>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Denis Vlasenko'" <vda@ilport.com.ua>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
References: <005501c59c4a$f6210800$a20cc60a@amer.sykes.com> <42F872E3.3050106@scram.de> <AC074A82-2B17-485A-9BFE-090CB4EE6E44@mac.com>
In-Reply-To: <AC074A82-2B17-485A-9BFE-090CB4EE6E44@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508091624.17381.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 9 of August 2005 15:52, Kyle Moffett wrote:
> On Aug 9, 2005, at 05:09:55, Jochen Friedrich wrote:
> > Third, both ndiswrapper and binary-only drivers only work on one  
> > platform.
> >
> > E.g. broadcom has a binary-only driver for their WLAN card on  
> > Linux, but
> > only for mipsel (wrt54g).
> >
> > On Alpha or PowerPC, most WLAN equipment doesn't work under Linux,  
> > at all.
> 
> Definitely.  I want my Airport Extreme to work!  Many users of the  
> BCM4301 chip can get it to work (kinda) with Linux via ndiswrapper,
> but that means they are much less likely to participate in any kind of
> reverse engineering effort,

Do you know of anyone actually doing it?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
