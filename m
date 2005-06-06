Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVFFJ1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVFFJ1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 05:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFFJ1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 05:27:20 -0400
Received: from god.demon.nl ([83.160.164.11]:62737 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S261255AbVFFJ0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 05:26:12 -0400
Date: Mon, 6 Jun 2005 11:26:08 +0200
From: Henk <Henk.Vergonet@gmail.com>
To: Edgar Toernig <froese@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new 7-segments char translation API
Message-ID: <20050606092608.GA16471@god.dyndns.org>
References: <20050531220738.GA21775@god.dyndns.org> <429DAB07.1050900@anagramm.de> <20050604204403.GA10417@god.dyndns.org> <20050605005329.70d9461a.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605005329.70d9461a.froese@gmx.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2005 at 12:53:29AM +0200, Edgar Toernig wrote:
> By your reasoning /usr/dict/words had to be in the kernel,
> too.

Well by my reasoning you should, if possible, define some usefull
standards that will allow te reuse of these dictionaries within other
applications.

And while we're on the subject of whats IN or OUT, (and I'll bet if you
ask 10 kernel developers you'll get 10 answers but I try anyway ;)

In my philosophy the OS (kernel + device drivers) is an abstraction of
the machine, it should present the 'machine' in such a way that allows
for other abstractions such as a word processor to operate without having
to know the specifics of hardware devices.

To have a guideline on the 7 segments notation and to have a few defines
that allow ASCII chars to be represented on 7 segments displays also help
to support the 'machine' abstraction.

Wheter or not /usr/dict/words should be 'in the kernel' is not being
discussed here, so I am not going to elaborate on that.

Cheers,

henk


PS I am not on the list, so please use CC if you're interested in a response.
PS Please excuse any spelling mistakes, I don't have a spelling checker
installed...


