Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317593AbSGEW5r>; Fri, 5 Jul 2002 18:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSGEW5q>; Fri, 5 Jul 2002 18:57:46 -0400
Received: from viper.haque.net ([66.88.179.82]:11145 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S317593AbSGEW5p>;
	Fri, 5 Jul 2002 18:57:45 -0400
User-Agent: Microsoft-Entourage/10.1.0.2006
Date: Fri, 05 Jul 2002 19:00:14 -0400
Subject: Re: IBM Desktar disk problem?
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Anton Altaparmakov <aia21@cantab.net>
CC: <linux-kernel@vger.kernel.org>
Message-ID: <B94B9D3E.61B3%mhaque@haque.net>
In-Reply-To: <5.1.0.14.2.20020705215116.00b0a1e0@pop.cus.cam.ac.uk>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/02 17:05, "Anton Altaparmakov" <aia21@cantab.net> wrote:
> You should update your firmware regardless of using TCQ because the errors
> you experienced have nothing to do with TCQ but a lot to do with buggy
> firmware. See what I found written about the firmware update on this
> webpage (Phil Randal posted this URL earlier on in this thread):
>        http://www.geocities.com/dtla_update/
> 
> ---snip---
> While S.M.A.R.T. offline scan running in background, a read error could
> cause a potential failure. This is corrected with current microcode.
> 
> (A5AA/A6AA) will detect and prevent application specific usage patterns
> that cause excessive dwell times in particular areas.
> ---snip---


Do you or anyone happen to know if this firmware update fixes UDMA problems
with the drive (i.e. I can't use the drive on my HTP366 cause it'll lock up
the machine). I'm wondering if the firmware also addresses the issues that
caused the drive to be listed in the DMA blacklist.

Also I tried going to page earlier and wasn't able to get to it because of a
bandwidth threshold. I've since gotten through and mirrored the site to
<http://haque.net/dtla_update/>

Thanks

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.
   Don't drink and derive." --Unknown
 
=====================================================================


