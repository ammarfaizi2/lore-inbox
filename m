Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268805AbUJKL3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268805AbUJKL3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268799AbUJKL3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:29:40 -0400
Received: from CPE-203-51-28-190.nsw.bigpond.net.au ([203.51.28.190]:52206
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S268805AbUJKL3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:29:36 -0400
Message-ID: <416A6E93.5020205@eyal.emu.id.au>
Date: Mon, 11 Oct 2004 21:29:23 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
References: <20041011032502.299dc88d.akpm@osdl.org>
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/
> 
> - I wasn't going to do any -mm's until after 2.6.9 comes out.  But we need
>   this one so that people who have patches in -mm can check that I haven't
>   failed to push anything critical.  If there's a patch in here which you
>   think should be in 2.6.9, please let me know.

I use -mm because DVB with my AverMedia (761 and 771) does not work with 2.6.9-rc3.
Please push these if at all possible.

> v4l-msp3400-cleanup.patch
>   v4l: msp3400 cleanup
> 
> v4l-tuner-update.patch
>   v4l: tuner update
> 
> v4l-bttv-update.patch
>   v4l: bttv update
> 
> v4l-dvb-cx88-driver-update.patch
>   v4l/dvb: cx88 driver update
> 
> v4l-dvb-cx88-driver-update-fix.patch
>   v4l-dvb-cx88-driver-update-fix
> 
> DVB-update-saa7146.patch
>   DVB: update saa7146
> 
> DVB-documentation-update.patch
>   DVB: documentation update
> 
> DVB-skystar2-dvb-bt8xx-update.patch
>   DVB: skystar2 dvb bt8xx update
> 
> DVB-dvb-core-update.patch
>   DVB: core update
> 
> DVB-frontend-conversion.patch
>   DVB: frontend conversion
> 
> DVB-frontend-conversion2.patch
>   DVB: frontend conversion #2
> 
> DVB-frontend-conversion3.patch
>   DVB: frontend conversion #3
> 
> DVB-frontend-conversion4.patch
>   DVB: frontend conversion #4
> 
> DVB-add-frontend-1-2.patch
>   DVB: add frontend
> 
> DVB-add-frontend-2-2.patch
>   DVB: add frontend #2
> 
> DVB-new-driver-dibusb.patch
>   DVB: new driver for mobile USB Budget DVB-T devices
> 
> DVB-misc-driver-updates.patch
>   DVB: misc driver updates
> 
> DVB-frontend-updates.patch
>   DVB: frontend updates
> 
> V4L-follow-changes-in-saa7146.patch
>   V4L: follow changes in saa7146

-- 
Eyal Lebedinsky	 (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
