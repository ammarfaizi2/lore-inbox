Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbTIDDPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTIDDPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:15:37 -0400
Received: from holomorphy.com ([66.224.33.161]:40588 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264512AbTIDDPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:15:35 -0400
Date: Wed, 3 Sep 2003 20:15:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030904031549.GF4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com> <20030904005822.GC5227@work.bitmover.com> <20030904011253.GA4306@holomorphy.com> <20030904024904.GI5227@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904024904.GI5227@work.bitmover.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 06:12:53PM -0700, William Lee Irwin III wrote:
>> Virtualized devices are backed by real devices at some level, so the
>> distance from the node's physical location to the device's then matters.

On Wed, Sep 03, 2003 at 07:49:04PM -0700, Larry McVoy wrote:
> Go read what I've written about this.  There is no sharing, devices are 
> local or remote.  You share in the page cache only, if you want fast access
> to a device you ask it to put the data in memory and you map it.  It's 
> absolutely as fast as an SMP.  With no locking.

Given the lack of an implementation I'm going to have to take this
claim as my opportunity to bow out of tonight's discussion.

I'd love to hear more about it when there's something more substantial
to examine.


-- wli
