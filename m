Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbTGBPKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbTGBPKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:10:43 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:21148 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id S265032AbTGBPKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:10:38 -0400
Date: Wed, 2 Jul 2003 17:24:50 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: David Weinehall <tao@acc.umu.se>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix in-kernel genksyms for parisc symbols
In-Reply-To: <20030629221814.GQ17986@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.44.0307021718510.23679-100000@galba.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003, David Weinehall wrote:

> Could you divulge what version of flex you use, to simplify future
> changes?

Well, the standard RedHat 7.3 stuff - unfortunately that box is moving
currently, so I don't know the versions. But any version should work, the
diff may be bigger, but the interesting change is to lex.l, anyway.

--Kai

