Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWBMQKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWBMQKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWBMQKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:10:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54179 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750795AbWBMQKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:10:21 -0500
Date: Mon, 13 Feb 2006 17:10:20 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: seanlkml@sympatico.ca, sam@vilain.net, peter.read@gmail.com,
       matthias.andree@gmx.de, lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060213.160108.13290.atrey@ucw.cz>
References: <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD> <43EC88B8.nailISDH1Q8XR@burner> <43EFC1FF.7030103@vilain.net> <43F097AE.nailKUSK1MJ9O@burner> <BAYC1-PASMTP10B5F649DEDADD145E56BDAE070@CEZ.ICE> <20060213095038.03247484.seanlkml@sympatico.ca> <43F0A771.nailKUS131LLIA@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0A771.nailKUS131LLIA@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> If there is no interest to fox well known bugs in Linux, I would need to warn
> people from using Linux.

Except for mentioning some DMA related problems at the beginning of this
monstrous thread, you haven't shown anything which even remotely qualifies
as a bug.

You are only endlessly complaining about Linux not following the same
model of SCSI access as you love, which might be a little incovenient
for you, but that certainly doesn't make it a bug.

You tried to juggle with dubious POSIX references, but so far nobody has
found any place in POSIX or SuS saying that anything has to be stable
across mounts/umounts.

So what damned bugs are you speaking about?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"One single semicolon. A perfect drop of perliness. The rest is padding." -- S. Manandhar
