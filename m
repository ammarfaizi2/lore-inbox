Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUESMUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUESMUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 08:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUESMUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 08:20:22 -0400
Received: from sccmmhc91.asp.att.net ([204.127.203.211]:35774 "EHLO
	sccmmhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S262873AbUESMUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 08:20:21 -0400
Date: Wed, 19 May 2004 07:20:09 -0500 (EST)
Message-Id: <20040519.072009.92566322.wscott@bitmover.com>
To: mason@suse.com
Cc: elenstev@mesatop.com, torvalds@osdl.org, akpm@osdl.org, lm@bitmover.com,
       wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page?
From: Wayne Scott <wscott@bitmover.com>
In-Reply-To: <1084968622.27142.5.camel@watt.suse.com>
References: <Pine.LNX.4.58.0405180728510.25502@ppc970.osdl.org>
	<200405190453.31844.elenstev@mesatop.com>
	<1084968622.27142.5.camel@watt.suse.com>
X-Mailer: Mew version 4.0.64 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Mason <mason@suse.com>
> Good to hear.  We probably still need Andrew's truncate fix, this just
> isn't the right workload to show it.  Andrew, that reiserfs fix survived
> testing here, could you please include it?
> 
> -chris

BTW. We have had one other person report a similar failure.

http://db.bitkeeper.com/cgi-bin/bugdb.cgi?.page=view&id=2004-05-19-001

But if sounds like this problem is now understood.  It was a pleasure
to watch you guys, and someone should buy Steven a beer.  Or perhaps
order a pizza for his family because I suspect this took some of their
time.

-Wayne
