Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTIHEqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 00:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTIHEqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 00:46:04 -0400
Received: from fluent2.pyramid.net ([206.100.220.213]:42632 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP id S261702AbTIHEqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 00:46:00 -0400
X-Not-Legal-Opinion: IANAL I am not a lawyer
X-For-Entertainment-Purposes-Only: True
X-message-flag: Please update my contact to send plain-text mail only.
Message-Id: <5.2.1.1.0.20030907214214.01c25ac8@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 07 Sep 2003 21:47:58 -0700
To: Larry McVoy <lm@bitmover.com>, "Eric W. Biederman" <ebiederm@xmission.com>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: Scaling noise
Cc: Larry McVoy <lm@bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030908005749.GA24714@work.bitmover.com>
References: <m1wuckma9z.fsf@ebiederm.dsl.xmission.com>
 <20030903194658.GC1715@holomorphy.com>
 <105370000.1062622139@flay>
 <20030903212119.GX4306@holomorphy.com>
 <115070000.1062624541@flay>
 <20030903215135.GY4306@holomorphy.com>
 <116940000.1062625566@flay>
 <20030904010653.GD5227@work.bitmover.com>
 <m11xusnvqc.fsf@ebiederm.dsl.xmission.com>
 <20030907230729.GA19380@work.bitmover.com>
 <m1wuckma9z.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:57 PM 9/7/2003 -0700, Larry McVoy wrote:
>That's not "a machine" that's ~1150 machines on a network.  This business
>of describing a bunch of boxes on a network as "a machine" is nonsense.

Then you haven't been keeping up with Open-source projects, or the 
literature.  The development of virtual servers composed of clusters of 
Linux boxes on a private network appears to be a single machine to the 
outside world.  Indeed, a highly scaled Web site using such a cluster is 
indistinguishable from one using a mainframe-class computer (which for the 
past 30 years have been networks of specialized processors working together).

The difference is that the bulk of the nodes are on a private network, not 
on a public one.  Actually, the machines I have seen have been on a weave 
of networks, so that as data traverses the nodes you don't get a bottleneck 
effect.

It's a lot different than the Illiac IV I grew up with...

Satch



-- 
"People who seem to have had a new idea have often just stopped having an 
old idea." -- Dr. Edwin H. Land  

