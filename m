Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUCETik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 14:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbUCETik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 14:38:40 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:62602 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262110AbUCETij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 14:38:39 -0500
Date: Fri, 5 Mar 2004 20:37:49 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] v2.6.3 moduleparam-patches
Message-ID: <20040305203749.P30061@infomag.infomag.iguana.be>
References: <20040305174904.O30061@infomag.infomag.iguana.be> <20040305183706.GA26176@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040305183706.GA26176@redhat.com>; from davej@redhat.com on Fri, Mar 05, 2004 at 06:37:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> btw, it'd be nice to have CONFIG_WDT_501_FAN tuned into a module
> param instead of a compile time decision too. The "only turn this
> on if you have the fan tachometer set up" clause means that for
> example vendor kernels can't enable this.

Shouldn't be to hard to do. I'll have a look at it and post a new patch later this weekend so that you can test it.

Greetings,
Wim.

