Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWAZVGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWAZVGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWAZVGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:06:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:17616 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964894AbWAZVGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:06:13 -0500
Date: Thu, 26 Jan 2006 22:06:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: matthias.andree@gmx.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was:
  Rationale for RLIMIT_MEMLOCK?)
In-Reply-To: <43D7AE00.nailDFJ61L10Z@burner>
Message-ID: <Pine.LNX.4.61.0601262204370.27891@yvahk01.tjqt.qr>
References: <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
 <20060123212119.GI1820@merlin.emma.line.org> <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
 <43D78585.nailD7855YVBX@burner> <20060125142155.GW4212@suse.de>
 <Pine.LNX.4.61.0601251544400.31234@yvahk01.tjqt.qr> <43D7AE00.nailDFJ61L10Z@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(removing Jens and Lee, as previous posts made that quite clear)

>> I'm getting a grin:
>>
>> 15:46 takeshi:../drivers/ide > find . -type f -print0 | xargs -0 grep SG_IO
>> (no results)
>>
>> Looks like it's already non-redundant :)
>
>everything in drivers/block/scsi_ioctl.c  is duplicate code and I am sure I 
>would find more if I take some time....

In what linux kernel version have you found that file?



Jan Engelhardt
-- 
