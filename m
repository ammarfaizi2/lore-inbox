Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265391AbUBPHdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 02:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbUBPHdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 02:33:17 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:37898 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S265391AbUBPHdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 02:33:09 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or loop
	device?) on 2.6.*)
Date: Mon, 16 Feb 2004 07:28:40 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <c0prf8$m3c$1@abraham.cs.berkeley.edu>
References: <402A4B52.1080800@centrum.cz> <20040216014433.GA5430@leto.cs.pocnet.net> <20040215175337.5d7a06c9.akpm@osdl.org> <1076900296.5601.41.camel@leto.cs.pocnet.net>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1076916520 22636 128.32.153.228 (16 Feb 2004 07:28:40 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Mon, 16 Feb 2004 07:28:40 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout  wrote:
>At the moment it supports no IC (ECB mode) or [...]

Probably I'm misunderstanding something, but: Do you really mean that
you are using ECB mode?  How is that secure?  (Everyone knows why ECB
mode should almost never be used, right?)
