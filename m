Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262495AbSI2PVe>; Sun, 29 Sep 2002 11:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbSI2PVe>; Sun, 29 Sep 2002 11:21:34 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:53001 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262495AbSI2PVd>; Sun, 29 Sep 2002 11:21:33 -0400
Date: Sun, 29 Sep 2002 17:26:52 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929152652.GF29737@merlin.emma.line.org>
Mail-Followup-To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain> <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2002, Linus Torvalds wrote:

> Am I hapyy with current 2.5.x?  Sure. Are others? Apparently. But does 
> that mean that we have a top-notch VM and we should bump the major number? 
> I wish.
> 
> The block IO cleanups are important, and that was the major thing _I_ 
> personally wanted from the 2.5.x tree when it was opened. I agree with you 
> there. But I don't think they are major-number-material.
> 
> Anyway, people who are having VM trouble with the current 2.5.x series, 
> please _complain_, and tell what your workload is. Don't sit silent and 
> make us think we're good to go.. And if Ingo is right, I'll do the 3.0.x 
> thing.

I personally have the feeling that 2.2.x performed better than 2.4.x
does, but I cannot go figure because I'm using ReiserFS 3.6 file
systems. I'd also really like to give Linux 2.5.39 or whatever is
current a whirl, but I'm currently using LVM and I'd need anything to
read that. Which one (EVMS or LVM2) is an ignorant-proof install and
reliable enough to read old LVM1 partitions and volumes?
