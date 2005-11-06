Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbVKFRTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVKFRTE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 12:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVKFRTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 12:19:04 -0500
Received: from outbound05.telus.net ([199.185.220.224]:18330 "EHLO
	priv-edtnes40.telusplanet.net") by vger.kernel.org with ESMTP
	id S1751064AbVKFRTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 12:19:03 -0500
From: Andi Kleen <ak@suse.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: [PATCH] x86-64: dma_ops for DMA mapping - K3
Date: Sun, 6 Nov 2005 18:18:44 +0100
User-Agent: KMail/1.8
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@ScaleMP.com)" <shai@scalemp.com>, niv@us.ibm.com,
       Jon Mason <jdmason@us.ibm.com>, Jimi Xenidis <jimix@watson.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>
References: <20051106131112.GE24739@granada.merseine.nu> <200511061745.54266.ak@suse.de> <20051106170649.GI3423@mea-ext.zmailer.org>
In-Reply-To: <20051106170649.GI3423@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511061818.45878.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 November 2005 18:06, Matti Aarnio wrote:

>
> git7 blows up like git2, git9 plain was not tested at all.
> I am applying the debug patch and compiling right now for a test.

Please just test plain git9 and post full boot log if it fails.

-Andi
