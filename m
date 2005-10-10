Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVJJRCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVJJRCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVJJRCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:02:36 -0400
Received: from ns.firmix.at ([62.141.48.66]:9638 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750955AbVJJRCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:02:35 -0400
Subject: Re: [PATCH] Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256
	limit
From: Bernd Petrovitsch <bernd@firmix.at>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <434A959E.5020602@gmail.com>
References: <4315B668.6030603@gmail.com>
	 <20050831215757.GA10804@taniwha.stupidest.org> <431628D5.1040709@zytor.com>
	 <431DF9E9.5050102@gmail.com> <431DFEC3.1070309@zytor.com>
	 <431E00C8.3060606@gmail.com> <4345A9F4.7040000@uni-bremen.de>
	 <434A6220.3000608@gmx.de>
	 <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com>
	 <434A8082.9060202@zytor.com>
	 <9e0cf0bf0510100759v722bbc5ay970b1aa99efba898@mail.gmail.com>
	 <434A82D7.7020605@zytor.com>  <434A959E.5020602@gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 10 Oct 2005 19:02:30 +0200
Message-Id: <1128963750.13409.61.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 18:23 +0200, Alon Bar-Lev wrote:
[...]
> Do you want me yo suggest the update? I will be glad!
                    ^^^^^^^
Probably.

> I don't really understand (yet) how you guys working... I am 
> learning... So please help me understand.

1) You want something changed, you propse a (tested) patch which
   actually changes the code you want. And then be prepared that
2) (at least) the maintaniners of concerned
   drivers/architectures/subsystems may have some seriuos problems with
   the direction your patch points to (let alone coding style).
3) Then you update/improve your patch.
4) Goto 1 until the patch is accepted or you withdraw it.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

