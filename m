Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272433AbTGaJlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 05:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272443AbTGaJlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 05:41:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7895 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S272433AbTGaJlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:41:31 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 31 Jul 2003 11:41:25 +0200 (MEST)
Message-Id: <UTC200307310941.h6V9fP204094.aeb@smtp.cwi.nl>
To: fvw@var.cx, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2+Util-linux/cryptoapi
Cc: Andries.Brouwer@cwi.nl, linux-crypto@nl.linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First of all, in util-linux 2.12 the keybits option is gone
> I wanted to have losetup/mount hash the passphrase

The patches I got were maximal, too much junk.
So I went for a minimal version instead.

It is usable (when the kernel part is stable, which it isn't today)
but mount/losetup may well acquire a few options before it is
conveniently usable.

(I do not read crypto lists, and see only a very small fraction of
what passes by on lk, so if you want to influence util-linux
an explicit cc is a good idea.)

> has the encryption setup changed again since 2.4.x with hvr's
> testing cryptoapi stuff?

cryptoloop as it went in is essentially hvr's.

Andries
