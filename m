Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263917AbTDNTTS (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTDNTTS (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:19:18 -0400
Received: from fmr01.intel.com ([192.55.52.18]:16332 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263917AbTDNTTR convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:19:17 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAD8D@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Bryan Shumsky'" <bzs@via.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Memory mapped files question
Date: Mon, 14 Apr 2003 12:31:01 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Bryan Shumsky [mailto:bzs@via.com]

> Hi, everyone.  I'm running into a problem that I hope someone else has
seen,
> and maybe can help solve.  We're using the mmap system function for memory
> mapped files, but our updates never get flushed until we munmap or msysnc.

I thought that was the way it was supposed to work.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
