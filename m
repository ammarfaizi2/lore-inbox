Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946538AbWJSVsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946538AbWJSVsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946535AbWJSVsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:48:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41858 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946538AbWJSVsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:48:01 -0400
Subject: Re: [PATCH 7/7] Char: isicom, check kmalloc retval
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <2618228894234632957@wsc.cz>
References: <2618228894234632957@wsc.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 22:50:37 +0100
Message-Id: <1161294637.17335.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 22:26 +0200, ysgrifennodd Jiri Slaby:
> isicom, check kmalloc retval
> 
> Value returned from kamlloc may be NULL, we should check if ENOMEM occured.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

