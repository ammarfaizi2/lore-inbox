Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVCABeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVCABeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVCABeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:34:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19220
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261191AbVCABen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:34:43 -0500
Date: Tue, 1 Mar 2005 02:34:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [andrea@cpushare.com: Re: [Twisted-Python] linux kernel 2.6.11-rc broke twisted process pipes]
Message-ID: <20050301013442.GY8880@opteron.random>
References: <20050301010728.GX8880@opteron.random> <Pine.LNX.4.58.0502281714420.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502281714420.25732@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 05:16:35PM -0800, Linus Torvalds wrote:
> I assume you mean 2.6.11-rc5, not 2.6.5-rc11.

Indeed sorry, I've probably typed that 2.6.5 number too many times ;)

> As you say, for pipes, none. It only matters on sockets that can have
> urgent data (aka oob - out-of-band data).

Ok thanks.
