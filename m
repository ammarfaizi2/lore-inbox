Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbTDXNTl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbTDXNTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:19:41 -0400
Received: from almesberger.net ([63.105.73.239]:55048 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263655AbTDXNTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:19:39 -0400
Date: Thu, 24 Apr 2003 10:31:26 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ben Collins <bcollins@debian.org>, Pat Suwalski <pat@suwalski.net>,
       Pavel Machek <pavel@ucw.cz>, Matthias Schniedermeyer <ms@citd.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424103126.L3557@almesberger.net>
References: <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net> <20030423221749.GA9187@elf.ucw.cz> <3EA71533.4090008@suwalski.net> <20030423225520.GA32577@atrey.karlin.mff.cuni.cz> <20030423231920.D1425@almesberger.net> <3EA74BF1.2090700@suwalski.net> <20030424023434.GF354@phunnypharm.org> <20030424072215.GC28253@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424072215.GC28253@mail.jlokier.co.uk>; from jamie@shareable.org on Thu, Apr 24, 2003 at 08:22:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> So why do we enable the PC-speaker beep automatically?
> Shouldn't that be silent initially too?

The difference to "sound" is that it won't make noise unless asked
to. So it starts with a safe default, and the rest is user policy.

On notebooks, I usually switch it off in my rc scripts after it's
been bothering me for the first time. Interesting ... I just
checked, and it seems that all my machines turn it off by default,
even without me knowingly doing something :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
