Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWHRWfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWHRWfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWHRWfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:35:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18095 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751545AbWHRWfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:35:37 -0400
Subject: Re: [PATCH 2.6.18-rc4] aoe [05/13]: jumbo frame support 1 of 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <97948359087e967864258908d9459187@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
	 <97948359087e967864258908d9459187@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Aug 2006 23:56:35 +0100
Message-Id: <1155941795.31543.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 13:39 -0400, ysgrifennodd Ed L. Cashin:
> Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
> 
> Add support for jumbo ethernet frames.
> (This patch depends on patch 7 to follow.)

Acked-by: Alan Cox <alan@redhat.com>

(but please keep changes that need each other and are small together so
you don't cause pain when binary searching for errors)

