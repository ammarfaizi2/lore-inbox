Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265008AbVBFAOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbVBFAOx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264983AbVBFAOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:14:51 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:43434 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265713AbVBFAMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:12:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=sznWpdJDOe6exccfJb/ChsVaDOpstfEpH6RQOIdxQxhxSdBZl05SU0vPTu/7sasQTaLCqMPYlngnFZJhHC1ZEUH/ipeWTN4XSnqfkBpulg8uXgNxT55cbm4v8L6CRNIPQ2Q/Ur0IhTZ7yxDE3EIA4XZ66Bmgn9duYQ5mqD6fAwU=
Message-ID: <58cb370e050205161262282797@mail.gmail.com>
Date: Sun, 6 Feb 2005 01:12:04 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 02/14] ide_pci: Merges aec62xx.h into aec62xx.c
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050204071317.C864C13264D@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071317.C864C13264D@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:17 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 02_ide_pci_aec62xx_merge.patch
> 
>         Merges ide/pci/aec62xx.h into aec62xx.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
