Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264696AbTIDDtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264699AbTIDDtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:49:05 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:49422
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264696AbTIDDtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:49:02 -0400
Date: Wed, 3 Sep 2003 20:49:17 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030904034917.GP16361@matchmail.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com> <116940000.1062625566@flay> <20030904010653.GD5227@work.bitmover.com> <20030904013253.GB4306@holomorphy.com> <7420000.1062642672@[10.10.2.4]> <20030904024051.GO16361@matchmail.com> <9320000.1062643806@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9320000.1062643806@[10.10.2.4]>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 07:50:07PM -0700, Martin J. Bligh wrote:
> >From all accounts, OpenSSI sounds more promising, but I need to spend some
> more time looking at it.

No kidding.

Taking a look at the web site it does look pretty impressive.  And it is
using other code that was integrated recently (linux virtual server), as
well as lustre, opengfs, etc.  This looks like they're making a lot of
progress, and doing it in a generic way.

I hope the code is as good as their documentation, and marketing...
