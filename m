Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbTFMEYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 00:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTFMEYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 00:24:18 -0400
Received: from ip68-2-19-97.ph.ph.cox.net ([68.2.19.97]:43138 "EHLO
	dent.deepthot.org") by vger.kernel.org with ESMTP id S265128AbTFMEYR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 00:24:17 -0400
From: Jay Denebeim <denebeim@deepthot.org>
X-Newsgroups: dt.kernel
Subject: Re: lockup on USB event kernel 2.4.20
Date: Fri, 13 Jun 2003 04:32:57 +0000 (UTC)
Organization: Deep Thought
Message-ID: <slrnbeikvp.iob.denebeim@hotblack.deepthot.org>
References: <1055446401.4948.408.camel@jma1.dev.netgem.com>
X-Complaints-To: news@deepthot.org
User-Agent: slrn/0.9.7.4 (Linux)
To: linuxkernel@deepthot.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1055446401.4948.408.camel@jma1.dev.netgem.com>, Jocelyn Mayer wrote:

> Is your controler a UHCI one ?

Appears to be using the OHCI driver, so no.

> If yes, try to connect your mouse via a hub if it's directly
> connected to your computer.

Tried it anyway, no joy.

Any other ideas?  Something I could debug would be good.  There's a
definate correlation between moving the mouse and locking up the
machine.  Presumably it is missing an interrupt or something like
that.

Jay

-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *
