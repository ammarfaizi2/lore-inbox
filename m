Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWH2KuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWH2KuB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 06:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWH2KuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 06:50:01 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61881 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932270AbWH2KuA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 06:50:00 -0400
Subject: Re: [PATCH] HPA resume fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <44F40F06.4010408@PicturesInMotion.net>
References: <44F40F06.4010408@PicturesInMotion.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Aug 2006 12:11:51 +0100
Message-Id: <1156849911.6271.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-29 am 05:55 -0400, ysgrifennodd Lee Trager:
> This patch fixes a problem with computers that have HPA on their hard
> drive and not being able to come out of resume from RAM or disk. This is
> my first patch to the kernel and third time submitting it, hopefully I
> got it right this time.
> 
> Signed-off-by: Lee Trager <Lee@PicturesInMotion.net>

For -mm only to get more testing

Acked-by: Alan Cox <alan@redhat.com>
