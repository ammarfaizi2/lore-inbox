Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262734AbTCJE4f>; Sun, 9 Mar 2003 23:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262725AbTCJEzi>; Sun, 9 Mar 2003 23:55:38 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:63900 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262729AbTCJEy5>; Sun, 9 Mar 2003 23:54:57 -0500
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: struct inode size reduction.
References: <20030309135402.GB32107@suse.de>
	<20030309224552.GA3047@werewolf.able.es>
	<20030310001129.GB13869@suse.de>
	<20030309235934.GA3962@werewolf.able.es>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 10 Mar 2003 14:04:57 +0900
In-Reply-To: <20030309235934.GA3962@werewolf.able.es>
Message-ID: <buoy93ng6bq.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> writes:
> That was my point, I do not know if some arch still requires 2.95 in 2.6.
> For 2.4, it states 2.95.3 as minimun.

Even if no arch `requires' gcc 2.95 (I don't really know, though until
recently my arch didn't even _have_ a [working] gcc 3.x port!), there
are certainly a buttload of people _using_ it to build the kernel, so
requiring gcc 3.2, would be kind of obnoxious.

-Miles
-- 
Come now, if we were really planning to harm you, would we be waiting here, 
 beside the path, in the very darkest part of the forest?
