Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVAUXZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVAUXZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVAUXZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:25:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:34781 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262561AbVAUXTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:19:33 -0500
To: jnf <jnf@innocence-lost.us>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: linux capabilities ?
References: <Pine.LNX.4.61.0501201053070.24484@fhozvffvba.vaabprapr-ybfg.arg>
	<20050120134918.N469@build.pdx.osdl.net>
	<Pine.LNX.4.61.0501201547230.24484@fhozvffvba.vaabprapr-ybfg.arg>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 22 Jan 2005 00:19:14 +0100
Message-ID: <87hdlapdzh.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jnf <jnf@innocence-lost.us> writes:

> Thank you, when I get a second I will take a look through it. I've already
> written a couple programs to set/get capabilities, so I am aware of the
> interface/api, it was just that even with the capabilities it was not
> working ;]
> Either way I will take a look through the code, I appreciate the reply.

You might want to look at
<http://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/capfaq-0.2.txt>

And in
<http://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/libcap-1.10.tar.bz2>,
you will find some example programs: execcap, setpcaps and sucap.

Regards, Olaf.
