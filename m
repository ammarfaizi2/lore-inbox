Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWIOSJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWIOSJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWIOSJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:09:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43149 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751337AbWIOSJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:09:53 -0400
Subject: Re: [PATCH] libata: fix non-uniform ports handling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       "Nelson A. de Oliveira" <naoliv@gmail.com>
In-Reply-To: <20060915180415.GB25800@htj.dyndns.org>
References: <20060915180415.GB25800@htj.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 19:32:56 +0100
Message-Id: <1158345176.29932.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-16 am 03:04 +0900, ysgrifennodd Tejun Heo:
> Non-uniform ports handling got broken while updating libata to handle
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Nelson A. de Oliveira <naoliv@gmail.com>


Acked-by: Alan Cox <alan@redhat.com>


