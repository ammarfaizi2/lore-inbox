Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271042AbRHXKcI>; Fri, 24 Aug 2001 06:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271055AbRHXKb7>; Fri, 24 Aug 2001 06:31:59 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:56588 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S271042AbRHXKbv> convert rfc822-to-8bit; Fri, 24 Aug 2001 06:31:51 -0400
Date: Fri, 24 Aug 2001 12:29:21 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: source control?
In-Reply-To: <E15a3tR-0004rN-00@the-village.bc.nu>
Message-ID: <20010824121239.T1242-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Aug 2001, Alan Cox wrote:

> > Is Linux development ever going to use source control?
>
> It does.

Pardon, I missed it. :)

> Or at least many of the development teams do.

Multiple source repositories means no-source-control, IMO.

> That doesn't mean a
> general CVS is a good idea.

So this means that most of programmers are probably idiots, given the
number of projects that use a _single_ source controlled repository. :)

> CVS make it all to easy for other people to
> push crap into your tree.

What other people?
You can only allow trusted people to commit, and backing out crap is quite
easy.

The only risk, in my opinion, of using a source-control system is that it
allows easy forking, that is often a bad idea for the long run. On all
other points, it is better, IMO, to use a source-control system with a
unique repository, than penguinish :) manual patching.

  Gérard.

