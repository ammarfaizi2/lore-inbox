Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291597AbSBMLl6>; Wed, 13 Feb 2002 06:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291603AbSBMLlo>; Wed, 13 Feb 2002 06:41:44 -0500
Received: from grisu.bik-gmbh.de ([194.233.237.82]:22030 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP
	id <S291599AbSBMLld>; Wed, 13 Feb 2002 06:41:33 -0500
Date: Wed, 13 Feb 2002 12:42:13 +0100
From: Florian Hars <florian@hars.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unknown Southbridge (was: Disk-I/O and kupdated@99.9% system (2.4.18-pre9))
Message-ID: <20020213114213.GA13515@bik-gmbh.de>
In-Reply-To: <20020208164250.GA321@bik-gmbh.de> <20020212102005.GB365@bik-gmbh.de> <20020212112349.A1691@suse.cz> <20020212133619.GA324@bik-gmbh.de> <20020212143816.A19597@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020212143816.A19597@suse.cz>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Feb 12, 2002 at 02:36:19PM +0100, Florian Hars wrote:
> > [Via VT8233A Southbridge]
>
> I've sent a patch to Jens Axboe for inclusion into 2.4, so it might be
> in 2.4.18. If you find any flaws, please tell me soon enough so I can
> stop the inclusion in time ...

I made a naive stress test (untaring a 5GB archive into an ext3 filesystem
on a LVM volume, while running fsx on the same filesystem (don't know if it
is relevant for this problem) and throwing in an occasional hdparm -Tt) and
everything looked good, even mozilla was still responsive. 

Thanks for your help.

Yours, Florian.
