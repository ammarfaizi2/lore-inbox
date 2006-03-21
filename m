Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWCUTGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWCUTGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWCUTGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:06:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40858 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964956AbWCUTGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:06:10 -0500
Date: Tue, 21 Mar 2006 20:06:07 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
In-Reply-To: <44204BD9.1090103@zytor.com>
Message-ID: <Pine.LNX.4.61.0603212005250.6840@yvahk01.tjqt.qr>
References: <1142890822.5007.18.camel@localhost.localdomain>
 <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com>
 <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr> <44203B86.5000003@zytor.com>
 <Pine.LNX.4.61.0603211854150.21376@yvahk01.tjqt.qr> <442040CB.2020201@zytor.com>
 <Pine.LNX.4.61.0603211911090.2314@yvahk01.tjqt.qr> <44204BD9.1090103@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > You're confusing characters which aren't legal *VFAT* names which those
>> > which
>> > aren't legal *FAT* (8.3) names.
>> 
>> Could you please name an illegal FAT name being legal VFAT name?
>
> "Green Furry Submarine"
>
Ah well. But aux.h is also forbidden under VFAT, is not it? Or no, because 
it's "just" an 8.3 name?


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
