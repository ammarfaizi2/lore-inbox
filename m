Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946535AbWJSVss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946535AbWJSVss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946541AbWJSVss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:48:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43138 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946535AbWJSVsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:48:47 -0400
Subject: Re: [PATCH 1/7] Char: isicom, expand function
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <243631749332825758@wsc.cz>
References: <243631749332825758@wsc.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 22:51:26 +0100
Message-Id: <1161294687.17335.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 22:26 +0200, ysgrifennodd Jiri Slaby:
> isicom, expand function
> 
> Simple functions (those, that calls reuest_irq, request_region et al) may be
> expanded directly in code. It makes probe function more readable and
> transparent.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

