Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVBQOva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVBQOva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVBQOv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:51:26 -0500
Received: from [213.188.213.77] ([213.188.213.77]:29637 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S262138AbVBQOuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:50:17 -0500
From: "Massimo Cetra" <mcetra@navynet.it>
To: "'Fao, Sean'" <sean.fao@capitalgenomix.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Netfilter: TARPIT Target
Date: Thu, 17 Feb 2005 15:50:11 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcUU/3MWMsH27/m1R6S11fikISEjIQAAGlEw
In-Reply-To: <4214AD2B.7020607@capitalgenomix.com>
Message-Id: <20050217145013.2C6E484008@server1.navynet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Fao, Sean
> Sent: Thursday, February 17, 2005 3:42 PM
> To: linux-kernel@vger.kernel.org
> Subject: Netfilter: TARPIT Target
> 
> I wanted to use the TARPIT target provided by Netfilter, but 
> I am unable to find the module in the kernel.  Has it been 
> removed or am I looking in the wrong place?

http://www.netfilter.org/patch-o-matic/pom-extra.html#pom-extra-TARPIT

TARPIT is in the extra repository.
Use patch-o-matic to patch both kernel and iptables source.

Regards,
 Max

