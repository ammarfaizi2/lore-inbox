Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265003AbVBFBu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265003AbVBFBu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 20:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272583AbVBFBu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 20:50:26 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:29431 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265003AbVBFBuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 20:50:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FOHFBpeo5IPmteR/KV00GY6dEwuwaMknuemLAO9VKw/RCXIF7NbY27mcRrMpwmOBGOvzM9xtfraQkxLVgCmMHvJtbY0ksICsiS/lKl6aabloYd+Ghc9aKMSJiNJ8aeIT3+mmMymuuJiC0EZZFpoW1KcPOwS8POnaM/U8rYzg8Z8=
Message-ID: <58cb370e05020517447748e049@mail.gmail.com>
Date: Sun, 6 Feb 2005 02:44:34 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 06/14] ide_pci: Merges hpt366.h into hpt366.c
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050204071318.59F79132654@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071318.59F79132654@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:18 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 06_ide_pci_hpt366_merge.patch
> 
>         Merges ide/pci/hpt366.h into hpt366.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
