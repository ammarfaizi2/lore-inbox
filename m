Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268327AbUHTQrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268327AbUHTQrX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268329AbUHTQrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:47:23 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:32398 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S268327AbUHTQrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:47:21 -0400
To: Andreas Jaeger <aj@suse.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       kernel@wildsau.enemy.org, diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	<d577e5690408190004368536e9@mail.gmail.com>
	<4124A024.nail7X62HZNBB@burner> <20040819131026.GA9813@ucw.cz>
	<4124AD46.nail80H216HKB@burner> <20040819135614.GA12634@ucw.cz>
	<4124B314.nail8221CVOE9@burner> <20040819141442.GC13003@ucw.cz>
	<20040819150704.GB1659@merlin.emma.line.org>
	<4124C46B.nail83H31GJ2S@burner> <hoy8k9kevf.fsf@reger.suse.de>
From: Julien Oster <lkml-7994@mc.frodoid.org>
Organization: FRODOID.ORG
Mail-Followup-To: Andreas Jaeger <aj@suse.de>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>, mj@ucw.cz,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
	kernel@wildsau.enemy.org, diablod3@gmail.com
Date: Fri, 20 Aug 2004 18:37:20 +0200
In-Reply-To: <hoy8k9kevf.fsf@reger.suse.de> (Andreas Jaeger's message of
 "Fri, 20 Aug 2004 17:28:52 +0200")
Message-ID: <87smah22bj.fsf@killer.ninja.frodoid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jaeger <aj@suse.de> writes:

>> What you see is 2 SuSE created bugs :-(

>> 1)	printing this message at all in this special case
>> 2)	SuSE using non initialized variables.

> I agree and I'm sorry about that.
> Thanks, I've filed bugreports for those and those will be fixed soon,

>  Andreas Jaeger, aj@suse.de, http://www.suse.de/~aj

Now, look, Jörg! Here is one of that fearful examples of a SuSE
employee. Unfriendly, not willing to fix anything, completely ignoring
bug reports!

Seriously, Jörg, stop bashing people, that's getting far beyond just
being impolite.

While I could just killfile you, I still feel that those discussions
are blocking serious development in that sector.

To you, Andreas: Thanks for the patches done in the past, they
actually do improve cdrecord.

Schöne Grüße,
Julien
