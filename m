Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUL3Xjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUL3Xjx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 18:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbUL3Xjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 18:39:53 -0500
Received: from smtp.gentoo.org ([156.56.111.197]:14247 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S261756AbUL3Xjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 18:39:44 -0500
From: Stefan Knoblich <stkn@gentoo.org>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Subject: Re: b44 ifconfig fails with ENOMEM
Date: Fri, 31 Dec 2004 00:39:43 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200412290557.29114.stkn@gentoo.org> <41D2B4B4.6090608@gmail.com> <20041229140333.GA27964@ee.oulu.fi>
In-Reply-To: <20041229140333.GA27964@ee.oulu.fi>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200412310039.43210.stkn@gentoo.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 29. Dezember 2004 15:03 schrieb Pekka Pietikainen:
>
> Quickest "fix" is to use a B44_DMA_MASK of 0xffffffff . Which is the
> pre-2.6.9 behaviour and is fine if you have <= 1GB of memory or use the
> standard 1:3 kernel:user split.

ok, will do that.

thanks a lot :)

stefan
