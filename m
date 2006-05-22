Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWEVUY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWEVUY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 16:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWEVUY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 16:24:27 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:49043 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751175AbWEVUY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 16:24:27 -0400
Date: Mon, 22 May 2006 22:24:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
In-Reply-To: <200605222015.01980.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222007.19456.s0348365@sms.ed.ac.uk>
 <44720CB6.7010908@zytor.com> <200605222015.01980.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Any idea why this wasn't done for bzip2?
>>
>> Yes, the bzip2 author I have been told was originally planning to do that,
>> but then thought it would be harder to deploy that way (because gzip is a
>> core utility, and people are nervous about making it larger.)

I'd say that concern is valid.

>It's a bit of a shame bzip2 even exists, really. It really would be better if 
>there was one unified, pluggable archiver on UNIX (and portables).

Would You Like To Contribute(tm)? :)
Whenever a program is missing, someone is there to write it.



Jan Engelhardt
-- 
