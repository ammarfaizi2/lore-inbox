Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVBFNDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVBFNDj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVBFNCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:02:38 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:63842 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261231AbVBFNC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:02:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pvmTpOyckIMSihXJ5O2slR7GGFJMhG1rBkQtEkYFG8B+HlSsOeId5ihIdXZwRM+xjT7Xts76ywerVT7YvlBaWQkFwpNEAg/afQhJpBttUdFsM3Re4RE8KdFchGDXLjSle/jUr1VybEKl0Ko6wNt2p8hvAf56vN0Nxiz1pP9gjyo=
Message-ID: <58cb370e0502060502462730eb@mail.gmail.com>
Date: Sun, 6 Feb 2005 14:02:28 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 12/14] ide_pci: Merges piix.h into piix.c
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050204071319.618DB132701@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071319.618DB132701@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:19 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 12_ide_pci_piix_merge.patch
> 
>         Merges ide/pci/piix.h into piix.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
