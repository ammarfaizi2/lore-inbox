Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbVBFCNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbVBFCNI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 21:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267836AbVBFCNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 21:13:08 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:8064 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267740AbVBFCNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 21:13:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bzTeCdd1AdEJl1lrQodzZ7hC20YHHsLuz9KNor7iUxSgFcPZxx++uG+YMe32HXaQCDTsVgBCHwJjl4YFuLVvf+De9uyE53iJdjVvNmHoYsQl9P9VndFAJeQ7inoaV0+EyGKhpYVz3pm2TkM9qvWrVlLNJHr7omg/r81k/gyzNTo=
Message-ID: <58cb370e0502051813c4da910@mail.gmail.com>
Date: Sun, 6 Feb 2005 03:13:02 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 09/14] ide_pci: Merges pdc202xx_new.h into pdc202xx_new.c
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050204071318.E58DB1326FA@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071318.E58DB1326FA@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:18 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 09_ide_pci_pdc202xx_new_merge.patch
> 
>         Merges ide/pci/pdc202xx_new.h into pdc202xx_new.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
