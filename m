Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWHGAmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWHGAmf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 20:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWHGAmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 20:42:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18858 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750855AbWHGAmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 20:42:35 -0400
Subject: Re: Mismatch between hdaprm and sdparm output
From: Arjan van de Ven <arjan@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <23691.1154910746@ocs3.ocs.com.au>
References: <23691.1154910746@ocs3.ocs.com.au>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 07 Aug 2006 02:42:23 +0200
Message-Id: <1154911344.3054.153.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 10:32 +1000, Keith Owens wrote:
> NEC Versa S5200 laptop with FUJITSU MHV2080B SATA disk.  Kernel
> 2.6.16.21-0.13-smp (suselinux 10.1) using ata_piix.  hdparm and sdparm
> give inconsistent results, which one should I believe?  My main concern
> is write caching (XFS filesystem).

well write caching you should be able to benchmark easily.. does, say,
dbench or tiobench show any difference ?


