Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbULPQFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbULPQFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbULPQFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:05:22 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:16789 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261629AbULPQEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:04:05 -0500
Date: Thu, 16 Dec 2004 17:03:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michelle Konzack <linux4michelle@freenet.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 3TB disk hassles
In-Reply-To: <20041216155216.GA3854@freenet.de>
Message-ID: <Pine.LNX.4.61.0412161703290.30336@yvahk01.tjqt.qr>
References: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com>
 <200412161537.02804.m.watts@eris.qinetiq.com> <20041216155216.GA3854@freenet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Are you sure your card supports creating a single volume in excess of
>> 2TB? 
>> Some cards have such a limit, although you can create many 2TB volumes
>> on the 
>> same card.
>
>You can have 4 TByte on one 12-Channel Card,
>but in two Arrays of 6 HDD's   :-)

Maybe some LVM trickery can aggregate ungrowable hardware raids together to a 
single block device.



Jan Engelhardt
-- 
ENOSPC
