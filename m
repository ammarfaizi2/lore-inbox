Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVBBX06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVBBX06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVBBX0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:26:30 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:30561 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262848AbVBBXVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:21:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qthuVBneeMkiij5XBlEPDf16mNj/irlEOCN+rvTaxlnRMeWYodPcAu5uscHRZ9U+58tsiS3dIAGm6MMA3R7fmo5ECNaKg0Pwy+kGK68/9JJlJ4QjRc8pA8G5zD+aSNOWgCKvJdI3HfiMfH+UBYIQJJvbi3BKQoar+CkPIM1qaNg=
Message-ID: <58cb370e05020215213206ccfc@mail.gmail.com>
Date: Thu, 3 Feb 2005 00:21:30 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] IDE: possible cleanups
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050131190154.GB18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050131190154.GB18316@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 20:01:54 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> This patch contains the following possible cleanups:
> - make some needlessly global code static
> - ide-dma.c: remove the unneeded EXPORT_SYMBOL(__ide_dma_test_irq)
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

applied
