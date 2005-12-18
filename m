Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965268AbVLRVYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965268AbVLRVYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 16:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbVLRVYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 16:24:16 -0500
Received: from graveyard.mail.t-online.hu ([195.228.240.17]:2555 "EHLO
	graveyard.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S965268AbVLRVYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 16:24:15 -0500
From: "Szloboda Zsolt" <slobo@t-online.hu>
To: "Neil Brown" <neilb@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: raid over sata - write barrier
Date: Sun, 18 Dec 2005 22:24:12 +0100
Message-ID: <JDEMIGCBPIDENEAIIGKPMECCCLAA.slobo@t-online.hu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <17317.51966.827057.524008@cse.unsw.edu.au>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with kernel 2.6.15, raid1
do I have to use the
-o barrier=1
mount option (or something else) when I mount the md device?

