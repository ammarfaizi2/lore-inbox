Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265125AbVBFB4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbVBFB4I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 20:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbVBFB4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 20:56:06 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:25889 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S272681AbVBFBz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 20:55:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Wrk5Z7HlNAcixnJrCYfGs7gH+6cqxhGGYJs62c+xdV3/s0dEbdd5Iciz93Z3z6tUNPSO/uHM9DQRD6rgEArBgZ6jro9K8Z/9pANv5zrF8iNTgKzhlvnsOsRFwphl3j4b+LG015/f1wAlyIiO5MFnHw3/iSWUfLWSMm9qP7jGIzw=
Message-ID: <58cb370e05020517553b48611c@mail.gmail.com>
Date: Sun, 6 Feb 2005 02:55:55 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 07/14] ide_pci: Merges it8172.h into it8172.c
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050204071318.9595F132656@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071318.9595F132656@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:18 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 07_ide_pci_it8172_merge.patch
> 
>         Merges ide/pci/it8172.h into it8172.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
