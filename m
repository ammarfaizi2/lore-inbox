Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281391AbRLACnZ>; Fri, 30 Nov 2001 21:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281403AbRLACnO>; Fri, 30 Nov 2001 21:43:14 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:6025 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S281391AbRLACnL>; Fri, 30 Nov 2001 21:43:11 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200112010242.CAA12521@mauve.demon.co.uk>
Subject: Re: Please tag tested releases of the 2.4.x kernel
Date: Sat, 1 Dec 2001 02:42:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011130171017.L504@mikef-linux.matchmail.com> from "Mike Fedyk" at Nov 30, 2001 05:10:17 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, Dec 01, 2001 at 02:05:21AM +0100, willy tarreau wrote:
> > I think that if even one tenth of the LKML
> > subscribers rank their kernels at least once a week,
> > we'll quickly see some stable and unusable kernels.
> > 
> 
> I like this idea a lot.
> 
> Who can get such a system up and running?  Which web site?

I've proposed in the past a more extensive version of this.
make register
or similar.
Which you run, and it grabs a snapshot of system setup, optionally
with comments, and sends it in to a registry.
You can then do 
make comment
and report issues.
These would vary from "it crashes", to "my hard drive died/is dying"
So we get information on systems, and some idea on which are reliable
or not.

Last time some people disagreed with this obviously brilliant idea. :/
