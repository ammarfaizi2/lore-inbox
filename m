Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268664AbVBFCXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268664AbVBFCXa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 21:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268617AbVBFCX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 21:23:29 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:65207 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269270AbVBFCW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 21:22:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=i4x8UcD7+6/C1EMCYvKatH4grJlqq6337iVGJhOcE2kUbwIF2AtxU+Bp3zjPOjJQR6b/LKD/ybs5xvlGePrbjJnd+5e3pz6IxbreS3mQJS10XvXAUEfxs3ojkO8f77d2AkfbXOG5uqYVWaFrq/jl7kcUxvX2IasL88vi5xTBzXA=
Message-ID: <58cb370e05020518225cb6d29d@mail.gmail.com>
Date: Sun, 6 Feb 2005 03:22:57 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 10/14] ide_pci: Removes SPLIT_BYTE macro from pdc202xx_old
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050204071319.16B3E1326FB@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071319.16B3E1326FB@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:19 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 10_ide_pci_pdc202xx_old_cleanup.patch
> 
>         Removes SPLIT_BYTE macro from ide/pci/pdc202xx_old driver.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
