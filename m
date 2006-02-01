Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWBAPvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWBAPvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWBAPvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:51:41 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27268 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422642AbWBAPvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:51:40 -0500
Date: Wed, 1 Feb 2006 16:51:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, matthias.andree@gmx.de,
       mrmacman_g4@mac.com, linux-kernel@vger.kernel.org, bzolnier@gmail.com,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future
 Linux (stirring up a hornets' nest) ]
In-Reply-To: <20060130232609.GA3631@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0602011650390.22529@yvahk01.tjqt.qr>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <43DCA097.nailGPD11GI11@burner> <20060129112613.GA29356@merlin.emma.line.org>
 <43DE2FF4.nail16ZCI3FMV@burner> <20060130170904.GH19173@merlin.emma.line.org>
 <43DE49C5.nail2BR31RV8R@burner> <20060130232609.GA3631@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> If you have the apropriate privs to send SCSI commands to any SCSI device 
>> on the system, you will not come across your problem.
>
>Why should I need privs to talk to *any* SCSI device, when I want to
>talk to just *one* SCSI device?
>

Because of the (drumroll...) -scanbus thing everyone wants!



Jan Engelhardt
-- 
