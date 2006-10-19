Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946545AbWJSVvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946545AbWJSVvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946547AbWJSVvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:51:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49120 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946548AbWJSVvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:51:08 -0400
Subject: Re: [PATCH 6/7] Char: isicom, use pci_request_region
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <10365316513231318476@wsc.cz>
References: <10365316513231318476@wsc.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 22:53:48 +0100
Message-Id: <1161294829.17335.127.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 22:26 +0200, ysgrifennodd Jiri Slaby:
> isicom, use pci_request_region
> 
> Use pci_request_region in pci probing function instead of request_region.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

