Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945922AbWJSOXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945922AbWJSOXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945967AbWJSOXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:23:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19885 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1945922AbWJSOXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:23:15 -0400
Subject: Re: [PATCH 1/1] Char: mxsers, correct tty driver name
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3160912811766612133@muni.cz>
References: <3160912811766612133@muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 15:25:48 +0100
Message-Id: <1161267948.17335.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 16:10 +0200, ysgrifennodd Jiri Slaby:
> mxsers, correct tty driver name
> 
> Mxser tty driver name should be ttyMI, not ttyM. Correct this in both
> drivers (mxser, mxser_new) to avoid conflicts with isicom driver, which is
> ttyM.
> 
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>


