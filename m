Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946541AbWJSVtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946541AbWJSVtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946542AbWJSVtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:49:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44162 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946541AbWJSVtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:49:10 -0400
Subject: Re: [PATCH 2/7] Char: isicom, rename init function
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <233127106965420505@wsc.cz>
References: <233127106965420505@wsc.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 22:51:49 +0100
Message-Id: <1161294709.17335.121.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 22:26 +0200, ysgrifennodd Jiri Slaby:
> isicom, rename init function
> 
> Rename init function from setup to init and mark it as __init, not __devinit.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>
