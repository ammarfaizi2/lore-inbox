Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVBFNSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVBFNSj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVBFNP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:15:58 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:26294 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261241AbVBFNOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:14:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fBTFWRmMuMhyL2us4V7xVOz10kAz1i0wHMdiwDgaW3VP0Xgdhvd8JfnGBz1CxdOh8spzNCToeHDq9PFE+VcQDnFdXy80bgB8mPAEczBY6REtCGRoVBiMVSnoopOrpgBEruQoAXeSI8pnc8217mqzFmdJgCE6vGcbB2GUS7Ap7dQ=
Message-ID: <58cb370e050206051349315961@mail.gmail.com>
Date: Sun, 6 Feb 2005 14:13:56 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH REPOST 2.6.11-rc2 14/14] ide_pci: Merges serverworks.h into serverworks.c
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050205000136.GA2420@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071319.0ED0E132703@htj.dyndns.org>
	 <20050205000136.GA2420@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2005 09:01:36 +0900, Tejun Heo <tj@home-tj.org> wrote:
>  Sorry, the original #14 added back SVWKS_DEBUG_DRIVE_INFO which #13
> removed.  This is the regenerated patch.
> 
> 14_ide_pci_serverworks_merge.patch
> 
>         Merges ide/pci/serverworks.h into serverworks.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied

> +/*
> + *     Table of the various serverworks capability blocks
> + */

this comment doesn't really explain anything, dropped
