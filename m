Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbTCGIAk>; Fri, 7 Mar 2003 03:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbTCGIAk>; Fri, 7 Mar 2003 03:00:40 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:53376 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261431AbTCGIAj>; Fri, 7 Mar 2003 03:00:39 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
	<20030306222328.14b5929c.akpm@digeo.com>
	<Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
	<20030306233517.68c922f9.akpm@digeo.com>
	<buoisuv1uyh.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030306235845.661fc4ab.akpm@digeo.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 07 Mar 2003 17:10:23 +0900
In-Reply-To: <20030306235845.661fc4ab.akpm@digeo.com>
Message-ID: <buobs0n1tsg.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:
> Although at some point we really do need to stop cleaning stuff up,
> defer such things into 2.7 and concentrate upon 2.5 bugs.

Agreed, though I think this particular cleanup is almost absurdly
straight-forward, and seems very unlikely to cause any problems
(for the most part it's really just moving stuff from one file to
another).

I'd think all the spelling corrections would be more controversial. :-)

-Miles
-- 
Suburbia: where they tear out the trees and then name streets after them.
