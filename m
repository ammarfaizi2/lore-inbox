Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268184AbTBXHLz>; Mon, 24 Feb 2003 02:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268196AbTBXHLz>; Mon, 24 Feb 2003 02:11:55 -0500
Received: from tag.witbe.net ([81.88.96.48]:57102 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S268184AbTBXHLy>;
	Mon, 24 Feb 2003 02:11:54 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Xinwen Fu'" <xinwenfu@cs.tamu.edu>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: how to force 10/100 speeds in Linux?
Date: Mon, 24 Feb 2003 08:22:06 +0100
Message-ID: <002101c2dbd5$6fabc400$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <Pine.SOL.4.10.10302232124240.17919-100000@dogbert>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	How can I force the speeds of the two cards at 10Mbps 
> or 100Mbps? Where can I find the parameter list to do such forcing?
> 
Have a look at :
 - mii-tool
 - ethtool
depending on your card.

Regards,
Paul


