Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUBEGgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 01:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbUBEGgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 01:36:47 -0500
Received: from science.horizon.com ([192.35.100.1]:57139 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261744AbUBEGgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 01:36:45 -0500
Date: 5 Feb 2004 06:36:44 -0000
Message-ID: <20040205063644.24593.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib rout
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hard to guess what the author's intent was as he left no license, but
> perhaps you're right. However, public domain works are routinely
> relicensed by publishers when they make a trivially derived work, see
> any reprint of Shakespeare or Bach. 

The author's intent was that the code is too damn trivial to start
making big important legal claims about.  If you are so easily impressed
that it seems like a major contribution to western literature[*], you can
sprinkle it with copyrighted holy penguin pee and add an appropriate
consecration notice.  (I.e. make trivial changes and assert copyright
over the changes.)

The disclaimer is not an attempt at a contract, but was intended as a
simple reminder of facts that should be obvious anyway.  If you think it's
pointless, feel free to delete it.  That's what "public domain" means.

It was inspired by distant memories of the very worthwhile InterSlip
license agreement, http://www.outercon.com/interslip.html
(I had a nice conversation with the lawyer that wrote it many years ago,
and she wanted to show that something could be funny and legally binding
at the same time.)

If MODULE_LICENSE can't cope with "Public domain", the that seems
to be a bug in MODULE_LICENSE, not grounds for a legalese workaround.
But whatever.

[*] You won't be completely alone; some people seem to think that <errno.h>
    has significant artistic merit, but personally I'm afraid that sharing
    that opinion would spread some horrible disease.
