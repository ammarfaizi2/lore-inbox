Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWD0JKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWD0JKJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 05:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWD0JKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 05:10:09 -0400
Received: from mx.laposte.net ([81.255.54.11]:27781 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S964999AbWD0JKH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 05:10:07 -0400
Date: Thu, 27 Apr 2006 11:09:52 +0200
Message-Id: <IYDISG$890C625CC6CB2CE334DB32E7E4CB6169@laposte.net>
Subject: Re:[PATCH 6/5] AIC7xxx : lock around channel reset
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: =?iso-8859-1?b?RW1tYW51ZWwgRnVzdOk=?= <emmanuel.fuste@laposte.net>
To: "hare" <hare@suse.de>
Cc: "James\.Bottomley" <James.Bottomley@SteelEye.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B103)
X-SenderIP: 127.0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [PATCH 6/5] AIC7xxx : lock around channel reset
> 
> This patch re-add the lock around channel reset which
> was wrongly removed by the qfrozen patch.
> 
> Signed-off-by: Emmanuel Fusté <emmanuel.fuste@laposte.net>
> ---

Hello,

Do you plan to merge these six patches for a future release ?

Regards,
Emmanuel.


Accédez au courrier électronique de La Poste : www.laposte.net ; 
3615 LAPOSTENET (0,34 €/mn) ; tél : 08 92 68 13 50 (0,34€/mn)



