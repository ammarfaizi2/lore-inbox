Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135626AbRDXOC3>; Tue, 24 Apr 2001 10:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135628AbRDXOCS>; Tue, 24 Apr 2001 10:02:18 -0400
Received: from corp2.cbn.net.id ([202.158.3.25]:26896 "HELO corp2.cbn.net.id")
	by vger.kernel.org with SMTP id <S135626AbRDXOCI>;
	Tue, 24 Apr 2001 10:02:08 -0400
Date: Tue, 24 Apr 2001 21:04:02 +0700 (JAVT)
From: <imel96@trustix.co.id>
To: Daniel Stone <daniel@kabuki.openfridge.net>
cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: problem found (was Re: [PATCH] Single user linux)
In-Reply-To: <20010424233801.A6067@piro.kabuki.openfridge.net>
Message-ID: <Pine.LNX.4.33.0104242046250.16242-100000@tessy.trustix.co.id>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Daniel Stone wrote:
> Aah. I see. Where was this? I never saw it.

psst, it's a proto.

> That may be so, so hack up your own OS. It's a MOBILE PHONE, it needs to be
> absolutely *rock solid*. Look at the 5110, that's just about perfect. The
> 7110, on the other hand ...

mobile phone to you! already, people has put linux on pdas.

> There are Linux advocates, but I'd say most of us are sane enough to use the
> right-tool-for-the-job approach. And UNIX on a phone is pure overkill.

problem is you guys are to unix-centric, try to be user-centric a little.
it's not like it ruins everything. that patch basically do something
like allowing access to port <1024 to everybody, someone just need
to bring a notebook to get passwd from nis.
multi-user security is useless at home as physical access is there.


		imel



