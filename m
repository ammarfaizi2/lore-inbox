Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbTEFFYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 01:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTEFFYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 01:24:36 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:6859 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261497AbTEFFYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 01:24:35 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v850] Add leading underline to new linker-script symbols on the v850
References: <20030506030925.388CC3760@mcspd15.ucom.lsi.nec.co.jp>
	<1052192261.983.10.camel@rth.ninka.net>
	<buohe88slo7.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030505.211459.21913657.davem@redhat.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 06 May 2003 14:36:51 +0900
In-Reply-To: <20030505.211459.21913657.davem@redhat.com>
Message-ID: <buod6iwskjw.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
>    I think in this case it's because I try to keep the v850 arch files
>    identical on 2.4.x and 2.5.x (as much as is possible), which sometimes
>    results in unused #defines on one or the other.
> 
> Please don't do that, 2.4.x and 2.5.x are different kernel.
> There will be differences, just accept them.

I will happily do so when requested.

> Therefore, please delete the flush_page_to_ram define on v850.

OK.

-Miles
-- 
`To alcohol!  The cause of, and solution to,
 all of life's problems' --Homer J. Simpson
