Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbULTMZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbULTMZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 07:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbULTMZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 07:25:06 -0500
Received: from 134-215-187-203.cable-client.iqara.net ([203.187.215.134]:54800
	"EHLO spsoftindia.com") by vger.kernel.org with ESMTP
	id S261493AbULTMZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 07:25:01 -0500
From: "Mukesh S. Bafna" <bafna.mukesh@spsoftindia.com>
To: "LinuxKernelMailingList" <linux-kernel@vger.kernel.org>
Cc: "SwapnilJoshi" <joshi.swapnil@spsoftindia.com>
Subject: buffer cache for SCSI 
Date: Mon, 20 Dec 2004 18:20:12 +0530
Message-ID: <DPEJLNNHEHGKGHFBKCFKOEBECFAA.bafna.mukesh@spsoftindia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

	I want to pass SCSI commands to RAID. Current md driver doesn't support
this. It uses buffer cache. I want to know how to create a cache on SCSI
based system? Is there any open source implementation available which does
this ?

Thanks and Regards
Mukesh

