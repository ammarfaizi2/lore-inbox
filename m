Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVFFP4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVFFP4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 11:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVFFP4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 11:56:13 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:10588 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261506AbVFFP4L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 11:56:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yn0ViMPtCZESqSx/Zbg1dje7+IMwNcOZO22ejNC0f5vs/ipCJol6Sz+nt9xG6LhH6EWjkbzfAAu1NDT/PnWO48sSzdyTd772RY+RovkEkHRYS8+n5xu+0PO/wpGPG+oDCWV1MGbic9x/dpDTMgYALZfDHwQ7mmmODXoFVru2IRE=
Message-ID: <58cb370e05060608551a4d2c85@mail.gmail.com>
Date: Mon, 6 Jun 2005 17:55:44 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: THESNIERES Sylvain <tmsec@free.fr>
Subject: Re: [2.6.11.10][Ali15x3] Crash at startup after disks detection in DMA66 mode
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e05060608452a6a1ce0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1117806619.42a0601b371b8@imp5-q.free.fr>
	 <58cb370e05060608452a6a1ce0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 6/3/05, THESNIERES Sylvain <tmsec@free.fr> wrote:
> > Hello. I used the kernel 2.6.10-gentoo-rc9 with my notebook (Pentium 4-M, no
> > trademark), it worked fine and I updated to 2.6.11.10 with fbsplash patch, and
> > now DMA causes the system to crash at boot time. I can't dump any message,
> 
> Could you elaborate on "DMA causes the system to crash"?
> 
> Does 2.6.10-rc5 work for you?

Ehm, 2.6.12-rc5 :-)
