Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUGZMGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUGZMGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 08:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUGZMGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 08:06:53 -0400
Received: from tarjoilu.luukku.com ([194.215.205.232]:60358 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S265224AbUGZMGw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 08:06:52 -0400
Message-ID: <4104E2CC.D8CBA56@users.sourceforge.net>
Date: Mon, 26 Jul 2004 13:54:04 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fruhwirth Clemens <clemens-dated-1091642568.f246@endorphin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
			<1090672906.8587.66.camel@ghanima>
			<41039CAC.965AB0AA@users.sourceforge.net>
			<1090761870.10988.71.camel@ghanima>
			<4103ED18.FF2BC217@users.sourceforge.net> <1090778567.10988.375.camel@ghanima>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens wrote:
> On Sun, 2004-07-25 at 19:25, Jari Ruusu wrote:
> > In short: exploit encodes watermark patterns as sequences of identical
> > ciphertexts.
> 
> Probably I'm missing the point, but at the moment this looks like a
> chosen plain text attack. As you know for sure, this is trivial. For
> instance, AES asserts to be secure against this kind of attack. (See the
> author's definition of K-secure..).

> I'm suggesting it doesn't work at all.

Fruhwirth, your incompetence has always amazed me. And this time is no
exception. What is conserning is that some mainline folks seem to listening
to your ill opinions. No wonder that both mainline device crypto
implementations are such a joke.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
