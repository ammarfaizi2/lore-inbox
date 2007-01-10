Return-Path: <linux-kernel-owner+w=401wt.eu-S964827AbXAJL3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbXAJL3a (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 06:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbXAJL3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 06:29:30 -0500
Received: from miranda.se.axis.com ([193.13.178.8]:37324 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964827AbXAJL33 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 06:29:29 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Patrick McHardy'" <kaber@trash.net>,
       "Mikael Starvik" <mikael.starvik@axis.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "Edgar Iglesias" <edgar.iglesias@axis.com>,
       "'Netfilter Development Mailinglist'" 
	<netfilter-devel@lists.netfilter.org>
Subject: RE: Iptable loop during kernel startup
Date: Wed, 10 Jan 2007 12:29:15 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668030B5907@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668044DEB07@exmail1.se.axis.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Which iptables/kernel versions are you using?

2.6.19. After further testing it seams to be a compiler/CPU issue. The exact

same kernelconfig works on ARM. So I have to dig some...

/Mikael

