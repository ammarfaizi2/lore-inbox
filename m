Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbUKELSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUKELSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 06:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUKELSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 06:18:13 -0500
Received: from mail.x-echo.com ([195.101.94.2]:21765 "EHLO mail.x-echo.com")
	by vger.kernel.org with ESMTP id S262644AbUKELSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 06:18:07 -0500
To: Stelian Pop <stelian@popies.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: meye bug?  No.
Mail-Copies-To: nobody
Organisation: =?iso-8859-15?q?=C9cho?= interactive
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
References: <20041104111231.GF3472@crusoe.alcove-fr>
	<87zn1xjoqo.fsf@mirexpress.internal.placard.fr.eu.org>
	<20041104215805.GB3996@deep-space-9.dsnet>
From: Roland Mas <roland.mas@free.fr>
Date: Fri, 05 Nov 2004 12:18:01 +0100
In-Reply-To: <20041104215805.GB3996@deep-space-9.dsnet> (Stelian Pop's
 message of "Thu, 4 Nov 2004 22:58:05 +0100")
Message-ID: <87actwo87q.fsf_-_@cachemir.echo-net.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop (2004-11-04 22:58:05 +0100) :

> On Thu, Nov 04, 2004 at 10:19:59PM +0100, Roland Mas wrote:

[...]

>> "meye: need to reset HIC!".  Repeatedly, as in about twice a second
>> until reboot.  Oh, and no picture ever comes out, either :-)
> [...]
>> sonypi: detected type1 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
>                                                               ^^^^^^^^^^^^
>
> :)

Okay, so I made a fool of myself, hope you had fun, sorry for the
inconvenience otherwise :-)

  Seriously though, and as much as I know I should have read the docs,
is this detectable from meye?  If it is, I suggest it would be a nice
thing to have a different or more explicit error message.  Just "meye:
need to reset HIC, is sonypi correctly configured?" would be cool.

Roland.
-- 
Roland Mas

Such compressed poems / With seventeen syllables / Can't have much meaning...
  -- in Gödel, Escher, Bach: an Eternal Golden Braid (Douglas Hofstadter)
