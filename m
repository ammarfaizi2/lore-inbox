Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269514AbTGJUL5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbTGJUL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:11:57 -0400
Received: from [212.209.10.216] ([212.209.10.216]:4267 "EHLO krynn.se.axis.com")
	by vger.kernel.org with ESMTP id S269514AbTGJUL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:11:56 -0400
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB03277AA6@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'Greg KH'" <greg@kroah.com>, "'Mikael Starvik'" <mikael.starvik@axis.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: CRIS architecture update
Date: Thu, 10 Jul 2003 22:26:31 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>As the driver is _in_ the kernel tree, why does it need to be compilable
>for older kernels?  :)

We have several customers running 2.4.17 or 2.4.19 that are happy with
these releases but needs the latest USB host controller bug fixes. It
 is probably not too hard to convince them to use 2.4.20 or newer.

/Mikael
