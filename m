Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVBFMxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVBFMxt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVBFMxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:53:49 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:20525 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261244AbVBFMxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:53:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ksGfdMNuRz0BFFDNUz/rB6CGiwPzfKmtykbpviDIi+WQjTXBTteQNeHmzE+ngC9dIylbVb/Mv+CnDPNtTSO5ghuUA+H9nHfPmW5GKCyscRCIEz6sXAsjxtrDSJz+8karkfnt/R9bbbptc5EVyt9RXR0czX+1Cimo4+kEI0Z4fSU=
Message-ID: <58cb370e05020604533657225c@mail.gmail.com>
Date: Sun, 6 Feb 2005 13:53:02 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 11/14] ide_pci: Merges pdc202xx_old.h into pdc202xx_old.c
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050204071319.3E7CB1326FC@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071319.3E7CB1326FC@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:19 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 11_ide_pci_pdc202xx_old_merge.patch
> 
>         Merges ide/pci/pdc202xx_old.h into pdc202xx_old.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
