Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVIOVOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVIOVOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVIOVOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:14:07 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:53151
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750889AbVIOVOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:14:05 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Pierre Ossman'" <drzeus-list@drzeus.cx>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'Netdev List'" <netdev@vger.kernel.org>,
       <ipw2100-admin@linux.intel.com>, <jt@hpl.hp.com>
Subject: RE: ipw2200 using old wireless extensions
Date: Thu, 15 Sep 2005 15:10:57 -0600
Message-ID: <00b501c5ba39$f7cff370$a20cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <4329E09B.9020807@drzeus.cx>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> With the inclusion of the ipw2200 driver and the update of
> the wireless
> extensions I get my dmesg flooded with these:
>
> eth0 (WE) : Driver using old /proc/net/wireless support,
> please fix driver !
>
> Somebody please make the hurting go away :)

Yes, we all are aware and getting dmesg spammed with these messages. Even
more if you have a Wireless Monitor applet that reads from the /proc
everytime.

Fix is on the way AFAIK.

.Alejandro

