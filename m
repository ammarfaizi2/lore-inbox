Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbWBNIEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbWBNIEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030512AbWBNIEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:04:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:56235 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030510AbWBNIEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:04:45 -0500
Date: Tue, 14 Feb 2006 09:04:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "D. Hazelton" <dhazelton@enter.net>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, mj@ucw.cz,
       seanlkml@sympatico.ca, sam@vilain.net, peter.read@gmail.com,
       matthias.andree@gmx.de, lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <200602131842.02377.dhazelton@enter.net>
Message-ID: <Pine.LNX.4.61.0602140903400.7198@yvahk01.tjqt.qr>
References: <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060213.160108.13290.atrey@ucw.cz>
 <43F0B32D.nailKUS1E3S8I3@burner> <200602131842.02377.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> -	SCSI commands are bastardized on ATAPI
>
>identify the problem - provide a test case or two and I'll get off my lazy ass 
>and see if I can't figure out what's causing the problem.
>

Maybe we can put a testsuite together that sends all sorts of commands to a 
cd drive and then see with 1. which Linuxes 2. which models it happens.


Jan Engelhardt
-- 
