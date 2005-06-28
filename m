Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVF1SwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVF1SwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVF1SwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:52:21 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:62626 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261187AbVF1SwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:52:13 -0400
Message-ID: <4783.10.10.10.24.1119984732.squirrel@linux1>
In-Reply-To: <200506281401.j5SE1ORW003589@laptop11.inf.utfsm.cl>
References: Message from Alexander Zarochentsev <zam@namesys.com>    of "Mon,
    27 Jun 2005 13:30:06 +0400." <200506271330.07451.zam@namesys.com>
    <200506281401.j5SE1ORW003589@laptop11.inf.utfsm.cl>
Date: Tue, 28 Jun 2005 14:52:12 -0400 (EDT)
Subject: Re: reiser4 plugins
From: "Sean" <seanlkml@sympatico.ca>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Cc: "Alexander Zarochentsev" <zam@namesys.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "David Masover" <ninja@slaphack.com>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Hans Reiser" <reiser@namesys.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       "ReiserFS List" <reiserfs-list@namesys.com>
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, June 28, 2005 10:01 am, Horst von Brand said:
>> I don't belive that you want to see all reiser4-specific things as item
>> plugins, disk format plugins in the VFS.
>
> Only what makes sense. Plus many of those will probably have to go. Decide
> on /one/ way of doing things, even if not perfect for all uses. Everything
> else is useless bloat.

It doesn't seem to be a problem as long as loadable plugins are GPL.  How
is it useless bloat?  It doesn't seem much different from having loadable
modules in the security system.  Just don't enable Reiser4 in your kernel
if you don't want to use it.

Sean


