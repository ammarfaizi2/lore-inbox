Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269704AbUJAFgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269704AbUJAFgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 01:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269709AbUJAFgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 01:36:23 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45585 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S269704AbUJAFf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 01:35:59 -0400
Date: Fri, 1 Oct 2004 07:33:01 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Miller, Mike (OS Dev)" <mike.miller@hp.com>,
       Christoph Hellwig <hch@infradead.org>, mikem@beardog.cca.cpqcorp.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org,
       "Baker, Brian (ISS - Houston)" <brian.b@hp.com>
Subject: Re: patch so cciss stats are collected in /proc/stat
Message-ID: <20041001053301.GE721@alpha.home.local>
References: <D4CFB69C345C394284E4B78B876C1CF107DBFE0B@cceexc23.americas.cpqcorp.net> <1096476186.2786.45.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096476186.2786.45.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 06:43:06PM +0200, Arjan van de Ven wrote:
> I doubt you have many customers using 2.4.28.... I suspect that by now
> the majority of people is either using an (ancient) 2.4 vendor kernel or
> a 2.6 kernel. The very low number of reports on lkml about 2.4 seems to
> confirm that ...

You must be kidding, aren't you ? I would better say that the very high
number of reports on lkml about 2.6 seems to confirm that 2.6 still is
a toy !

Marcelo has done a great job at getting 2.4 stable, and now people are
installing it in remote locations or embedded system with no planned
updated at all. And it works. Just like people did with 2.0 recently.
This may be why there are so few reports.

Willy

