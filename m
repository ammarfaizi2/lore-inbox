Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbTAaR5I>; Fri, 31 Jan 2003 12:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbTAaR5H>; Fri, 31 Jan 2003 12:57:07 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:29075 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261721AbTAaR5H>; Fri, 31 Jan 2003 12:57:07 -0500
Date: Fri, 31 Jan 2003 19:06:20 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Rodland <arodland@noln.com>,
       john@grabjohn.com
Subject: Re: [PATCH] 2.5.59 morse code panics
Message-ID: <20030131180620.GM12286@louise.pinerecords.com>
References: <20030130150709.GC701@louise.pinerecords.com> <20030130173642.GB25824@codemonkey.org.uk> <1043952334.31674.20.camel@irongate.swansea.linux.org.uk> <20030131185927.B25927@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030131185927.B25927@ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [vojtech@suse.cz]
> 
> It should be in the keyboard.c file, using input_event() to blink the
> LEDs. This way it'll work on all archs in 2.5.

Oh, thanks for pointing this out, Vojtech, I'll certainly fix it.

-- 
Tomas Szepe <szepe@pinerecords.com>
