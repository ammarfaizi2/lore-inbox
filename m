Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTJVCiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 22:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbTJVCiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 22:38:05 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:16140 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263365AbTJVCiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 22:38:03 -0400
Date: Tue, 21 Oct 2003 19:37:58 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Software RAID5 with 2.6.0-test
Message-ID: <20031022023758.GG17713@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20031018115049.GB760@gallifrey> <bn49pv$jbn$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bn49pv$jbn$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Vulnerable email reader detected!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 09:51:59PM +0000, bill davidsen wrote:
> In article <20031018115049.GB760@gallifrey>,
> Dr. David Alan Gilbert <gilbertd@treblig.org> wrote:
> 
> |   I'd love to see some real benchmarks to prove me wrong however!
> 
> Okay, I'm scheduled to build a system next month, give me the name of a
> good controller which will do four drives and which can be used as a
> dumb controller as well, and I'll grab six drives for the build and run
> a test (baring a change in schedule, obviously).

I'd try the 3ware.  AC and others have reported good
throughput and, at least compared to SCSI, they aren't that
expensive and claim to support JBOD.  I just checked on
pricewatch and the 7506-4 can be had for about $250US and
the eight port for about $375.  Older models can be had for
less.  When the economy picks back up enough to improve my
bank ballance i'm planning to buy a few.

> I'll run as many RAID configs as make sense, whatever the hardware
> supports. And also four way RAID-1 for a heavy read application, to see
> if the software RAID does better than the controller, if it can do that
> at all.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
