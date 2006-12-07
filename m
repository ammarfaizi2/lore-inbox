Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162570AbWLGRb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162570AbWLGRb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162571AbWLGRb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:31:57 -0500
Received: from mms3.broadcom.com ([216.31.210.19]:3109 "EHLO MMS3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162570AbWLGRb4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:31:56 -0500
X-Server-Uuid: 9206F490-5C8F-4575-BE70-2AAA8A3D4853
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: [2.6 patch] drivers/net/bnx2.c: add an error check
Date: Thu, 7 Dec 2006 09:31:40 -0800
Message-ID: <1551EAE59135BE47B544934E30FC4FC093FD91@NT-IRVA-0751.brcm.ad.broadcom.com>
In-Reply-To: <20061207113433.GC8963@stusta.de>
Thread-Topic: [2.6 patch] drivers/net/bnx2.c: add an error check
Thread-Index: AccZ87oxpiVqIQ6KQlCas/k8kodGrAAMbcbw
From: "Michael Chan" <mchan@broadcom.com>
To: "Adrian Bunk" <bunk@stusta.de>
cc: davem@davemloft.net, jgarzik@pobox.com, linux-kernel@vger.kernel.org
X-WSS-ID: 69668F882CC430870-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian Bunk wrote:
> This patch adds a missing error check spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
Acked-by: Michael Chan <mchan@broadcom.com>

