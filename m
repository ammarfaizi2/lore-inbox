Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbTIDC4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbTIDC4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:56:42 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:43173 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264524AbTIDCy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:54:56 -0400
Date: Wed, 03 Sep 2003 19:50:07 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <9320000.1062643806@[10.10.2.4]>
In-Reply-To: <20030904024051.GO16361@matchmail.com>
References: <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com> <116940000.1062625566@flay> <20030904010653.GD5227@work.bitmover.com> <20030904013253.GB4306@holomorphy.com> <7420000.1062642672@[10.10.2.4]> <20030904024051.GO16361@matchmail.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Am I missing something, but why hasn't openmosix been brought into this
> discussion?  It looks like the perfect base for something like this.  All
> that it needs is some cleanup.

>From what I've seen, it needs a redesign. I don't think it's maintainable
or mergeable as is ... nor would I want to work with their design. Just
an initial gut reaction, I haven't spent a lot of time looking at it, but
from what I saw, I didn't bother looking further.

>From all accounts, OpenSSI sounds more promising, but I need to spend some
more time looking at it.

M.

