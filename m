Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbUBKBOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUBKBOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:14:45 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:34822 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id S263537AbUBKBOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:14:39 -0500
Date: Wed, 11 Feb 2004 02:13:45 +0100
From: =?ISO-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: Why does ramfs always get built?
Message-ID: <20040211011345.GA15426@metuzalem.tesarici.cz>
References: <20040211010436.GA13684@metuzalem.tesarici.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211010436.GA13684@metuzalem.tesarici.cz>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux metuzalem 2.4.24 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 11.02.2004 v 02:04:36 (+0100), Petr Tesarik wrote:
> but maybe this is a known issue and the ramfs is needed for something
> I can't figure out (I recompiled my kernel without ramfs and it works
> fine, so there is at least one configuration which does _NOT_ require
> it and it should then definitely be optional anyway).

Ooops, sorry. My fingers were faster than my brain. Yes, of course I
did _NOT_ recompile the kernel without ramfs, I've messed up my
sources and ramfs is really needed for init_rootfs.

Sorry for the fuss. :(

bye,
Petr T.
