Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbULNPLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbULNPLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 10:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbULNPLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 10:11:53 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27274 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261520AbULNPLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 10:11:52 -0500
Date: Tue, 14 Dec 2004 16:11:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecording status
In-Reply-To: <20041214115102.GB23031@animx.eu.org>
Message-ID: <Pine.LNX.4.61.0412141611050.10000@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0412132255060.7005@yvahk01.tjqt.qr>
 <200412141049.39499@fortytwo.ch> <Pine.LNX.4.61.0412141117240.18625@yvahk01.tjqt.qr>
 <20041214115102.GB23031@animx.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Honestly I do not know, but I hope they can at least sustain as much as CD-RW 
>> can (usually 1000x). Plus, it's for DVD+RW, it always uses packet mode, and as 
>> such I damn hope that DVD+RW manufacturers keep in mind that a byte position 
>> might be overwritten more than 1000 times.
>
>Isn't that what DVD-RAM is for?  IIRC, it's overwrite count is 100,000.

Now that's "just" 100 times more than a CD/DVD. However, the buffer cache is a 
really nice thing to have -- especially on such media.



Jan Engelhardt
-- 
ENOSPC
