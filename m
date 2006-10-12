Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161547AbWJLKr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161547AbWJLKr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 06:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWJLKr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 06:47:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34490 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751183AbWJLKr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 06:47:29 -0400
Subject: Re: [PATCH] epca: privent from panic on tty_register_driver()
	failure
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       "Digi International, Inc" <Eng.Linux@digi.com>
In-Reply-To: <20061009090603.GA6278@localhost>
References: <20061009090603.GA6278@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Oct 2006 12:13:39 +0100
Message-Id: <1160651620.23731.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-09 am 18:06 +0900, ysgrifennodd Akinobu Mita:
> This patch makes epca fail on initialization failure instead of panic.
> 
> Cc: "Digi International, Inc" <Eng.Linux@digi.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

