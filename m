Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbULNKSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbULNKSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 05:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbULNKSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 05:18:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:48073 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261308AbULNKSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 05:18:46 -0500
Date: Tue, 14 Dec 2004 11:18:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian von Bidder <avbidder@fortytwo.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecording status
In-Reply-To: <200412141049.39499@fortytwo.ch>
Message-ID: <Pine.LNX.4.61.0412141117240.18625@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0412132255060.7005@yvahk01.tjqt.qr>
 <200412141049.39499@fortytwo.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have played a little with my new cd/dvd/whatnot writer and just had
>> this idea (see pic). Well then, DVD+RW makes it possible.
>>     http://linux01.org:2222/gfx0/madness.jpg
>
>Just wondering: how many write cycles do DVD+RW media support?

Honestly I do not know, but I hope they can at least sustain as much as CD-RW 
can (usually 1000x). Plus, it's for DVD+RW, it always uses packet mode, and as 
such I damn hope that DVD+RW manufacturers keep in mind that a byte position 
might be overwritten more than 1000 times.

