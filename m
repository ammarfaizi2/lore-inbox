Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbVBFAUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbVBFAUk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbVBFAUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:20:36 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:26332 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265841AbVBFAUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:20:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RcG+GY6HPZLAMoukgwTfcaFv72Lc2fMp56Kmv4Beb69PvSrfwVOaNNruotciu2CaeGenkBlfi1+1M8cS1Wn9YHdCVgLgOXYn2Ek8PxpmcxkEmYbQShqe/JKdMvCZOhkfIaVAJkjGdWNf0EmJVaxluubH1rOSd12R9UPFKuylFw0=
Message-ID: <58cb370e0502051620774e81bf@mail.gmail.com>
Date: Sun, 6 Feb 2005 01:20:10 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 03/14] ide_pci: Merges cmd64x.h into cmd64x.c
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050204071317.E373913264E@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071317.E373913264E@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:17 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 03_ide_pci_cmd64x_merge.patch
> 
>         Merges ide/pci/cmd64x.h into cmd64x.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
