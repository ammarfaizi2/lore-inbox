Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265000AbUFRGjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbUFRGjB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 02:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265001AbUFRGjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 02:39:00 -0400
Received: from tag.witbe.net ([81.88.96.48]:55713 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265000AbUFRGi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 02:38:59 -0400
Message-Id: <200406180638.i5I6cwX12193@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Randy.Dunlap'" <rddunlap@osdl.org>,
       "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] save kernel version in .config file
Date: Fri, 18 Jun 2004 08:38:58 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRU8u99NLaybkq4RUeXEX7JevE7fwAC53XA
In-Reply-To: <20040617220651.0ceafa91.rddunlap@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> 
> Is this interesting to anyone besides me?
> 
Is it also possible to have this version being displayed during
a make config/make menuconfig/... so that we know we are reading a
config file that may have been generated for another kernel version,
and not yet saved ?

You would have, for make menuconfig :

 Linux Kernel v2.2.13 Configuration, Configuration file version 2.4.20
....

Regards,
Paul

