Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSJVKA6>; Tue, 22 Oct 2002 06:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbSJVKA5>; Tue, 22 Oct 2002 06:00:57 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:51524 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S262395AbSJVKA5>; Tue, 22 Oct 2002 06:00:57 -0400
Date: Tue, 22 Oct 2002 03:15:19 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Rob Landley <landley@trommello.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Son of crunch time: the list v1.2.
In-Reply-To: <200210211642.10435.landley@trommello.org>
Message-ID: <Pine.LNX.4.44.0210220312180.24156-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Rob Landley wrote:
|>On Monday 21 October 2002 21:02, Jeff Garzik wrote:
|>> Rob Landley wrote:
|>> > 11) Linux Kernel Crash Dumps (Matt Robinson, LKCD team)
|>> > Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7060.html
|>> > Code: http://lkcd.sourceforge.net/
|>>
|>> I would personally _love_ to see this merged, but I think it's 2.7.x
|>> material given the recent comments (unless they get fixed up)
|>
|>T minus 6 days, and counting... :)

We've incorporated the majority of Christoph's requests, along
with changes requested by a few other developers.  We'll post the
next set later tonight after testing a few SMP/UP/IDE/SCSI crashes
with all of the changes.

There are a couple of things that we didn't change due to the
nature of the project, which I'll first discuss with Christoph
off-line to avoid going down a big rathole. :)  Suffice it to
say that we incorporated almost everything he asked for.

We'll make this deadline.

--Matt

