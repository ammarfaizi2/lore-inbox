Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267919AbTBVV3C>; Sat, 22 Feb 2003 16:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267920AbTBVV3C>; Sat, 22 Feb 2003 16:29:02 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9432 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267919AbTBVV3B>;
	Sat, 22 Feb 2003 16:29:01 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Larry McVoy <lm@bitmover.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sf.et,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Minutes from Feb 21 LSE Call 
In-reply-to: Your message of 22 Feb 2003 18:20:19 GMT.
             <1045938019.5034.9.camel@irongate.swansea.linux.org.uk> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16488.1045949791.1@us.ibm.com>
Date: Sat, 22 Feb 2003 13:36:31 -0800
Message-Id: <E18mhJw-0004I0-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Feb 2003 18:20:19 GMT, Alan Cox wrote:
> I think people overestimate the numbner of large boxes badly. Several IDE
> pre-patches didn't work on highmem boxes. It took *ages* for people to
> actually notice there was a problem. The desktop world is still 128-256Mb

IDE on big boxes?  Is that crack I smell burning?  A desktop with 4 GB
is a fun toy, but bigger than *I* need, even for development purposes.
But I don't think EMC, Clariion (low end EMC), Shark, etc. have any
IDE products for my 8-proc 16 GB machine...  And running pre-patches in
a production environment that might expose this would be a little
silly as well.

Probably a bad example to extrapolate large system numbers from.

gerrit
