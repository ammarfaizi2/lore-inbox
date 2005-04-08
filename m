Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262934AbVDHTiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVDHTiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbVDHTiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:38:16 -0400
Received: from mail.enyo.de ([212.9.189.167]:30906 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262934AbVDHTiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:38:13 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071428.GB3957@opteron.random>
	<Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
	<4256AE0D.201@tiscali.de>
	<Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
	<20050408171518.GA4201@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org>
	<20050408180540.GA4522@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
	<20050408191638.GA5792@taniwha.stupidest.org>
Date: Fri, 08 Apr 2005 21:38:09 +0200
In-Reply-To: <20050408191638.GA5792@taniwha.stupidest.org> (Chris Wedgwood's
	message of "Fri, 8 Apr 2005 12:16:38 -0700")
Message-ID: <878y3t5aam.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wedgwood:

>> It doesn't matter so much for the cached case, but it _does_ matter
>> for the uncached one.
>
> Doing the minimal stat cold-cache here is about 6s for local disk.

Does sorting by inode number make a difference?
