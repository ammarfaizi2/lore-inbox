Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271161AbTHLViM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271177AbTHLViL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:38:11 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:22977 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S271161AbTHLViD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:38:03 -0400
Message-ID: <30027.165.89.84.90.1060724334.squirrel@www.genebrew.com>
In-Reply-To: <20030812211816.GA22799@atrey.karlin.mff.cuni.cz>
References: <3F3954EB.1080406@gmx.net> 
     <20030812211816.GA22799@atrey.karlin.mff.cuni.cz>
Date: Tue, 12 Aug 2003 17:38:54 -0400 (EDT)
Subject: Re: Possible fix for NFORCE2 IDE hangups
From: "Rahul Karnik" <rahul@genebrew.com>
To: "Karel Kulhavy" <clock@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Last weekend I disabled the use of the APIC (the system now uses XT-PIC)
>> and this seems to fix the problem. The system ran stable with UDMA100
>> enabled for the last 4 days.
>
> Did the famous "spurious interrupt" messages go away too?

Running without APIC here on an MSI board I still get that message. But I
also get that same message on a bunch of different computers and it is not
harmful, so I don't worry too much about it.

Thanks,
Rahul
--
Rahul Karnik
rahul@genebrew.com
