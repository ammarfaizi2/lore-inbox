Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUCWIXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 03:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUCWIXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 03:23:40 -0500
Received: from vega.lgb.hu ([213.163.0.181]:8596 "EHLO lgb.hu")
	by vger.kernel.org with ESMTP id S262382AbUCWIXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 03:23:39 -0500
Date: Tue, 23 Mar 2004 09:23:38 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS: cleanup or throw away
Message-ID: <20040323082338.GD23546@lgb.hu>
Reply-To: lgb@lgb.hu
References: <200403221955.52767.jos@hulzink.net> <20040322202220.GA13042@mulix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040322202220.GA13042@mulix.org>
X-Operating-System: vega Linux 2.6.4 i686
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 10:22:21PM +0200, Muli Ben-Yehuda wrote:
> In my not so humble opinion, throwing OSS away will be a big mistake,
> as long as there are people willing to maintain it. Keep it there and
> let the users (or distributions) choose what to use. I've seen

Or better: since both of OSS and ALSA are sound systems, let OSS maintainers
start hacking ALSA, so missing parts in ALSA which presents in OSS can be
implemented. Having one sound system would be better, especially in the
official kernel tree. It's another story, if you have multiple one outside
the "official" kernel source. imho.

> multiple bug reports of cards that work with OSS and don't work with
> ALSA (and vice versa), so keeping both seems the proper thing to
> do. Personally, I maintain one OSS driver, and fix bugs in others
> occasionally. 

- Gábor (larta'H)
