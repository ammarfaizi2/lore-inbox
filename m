Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWH1VXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWH1VXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWH1VXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:23:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:11734 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751515AbWH1VXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:23:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 23:23:39 +0200
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, David Woodhouse <dwmw2@infradead.org>,
       David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org,
       jdike@addtoit.com, B.Steinbrink@gmx.de, arjan@infradead.org,
       chase.venters@clientec.com, akpm@osdl.org, rmk+lkml@arm.linux.org.uk,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <200608282020.k7SKKntv031777@laptop13.inf.utfsm.cl>
In-Reply-To: <200608282020.k7SKKntv031777@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608282323.40178.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Monday 28 August 2006 22:20 schrieb Horst H. von Brand:
> Could just this macro layer be explicitly BSD (or at least LGPL) licensed?
> If not, it looks like a SCOX-whining-over-errno.h thing in the making in
> case somebody wants to build a non-GPL libc on top...

klibc comes with a BSD licensed version of these macros.

	Arnd <><
