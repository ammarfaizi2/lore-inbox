Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUBUDJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 22:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUBUDJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 22:09:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:44165 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261491AbUBUDJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 22:09:51 -0500
Date: Fri, 20 Feb 2004 19:15:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: brown wrap <gramos@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: v2.6.3 blows up on compile
In-Reply-To: <20040221013853.8034.qmail@web11507.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0402201914210.3301@ppc970.osdl.org>
References: <20040221013853.8034.qmail@web11507.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, brown wrap wrote:
> 
> In trying to build a kernel, it always aborts in this
> area:

You have a broken compiler.

There are patches to work around it, but basically we don't want to apply 
them, because a broken compiler is scary enough that it's better if you 
upgrade that instead.

		Linus
