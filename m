Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314984AbSDWAnn>; Mon, 22 Apr 2002 20:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314986AbSDWAnm>; Mon, 22 Apr 2002 20:43:42 -0400
Received: from Expansa.sns.it ([192.167.206.189]:12550 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S314984AbSDWAnm>;
	Mon, 22 Apr 2002 20:43:42 -0400
Date: Tue, 23 Apr 2002 02:43:24 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Keith Owens <kaos@sgi.com>
cc: Wichert Akkerman <wichert@cistron.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel 
In-Reply-To: <6047.1019518162@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0204230235440.31961-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Apr 2002, Keith Owens wrote:

> On 22 Apr 2002 18:55:20 +0200,
> wichert@cistron.nl (Wichert Akkerman) wrote:
> >In article <3CC427F4.12C40426@fnal.gov>,
> >Dan Yocum  <yocum@fnal.gov> wrote:
> >>I know it's been discussed to death, but I am making a formal request to you
> >>to include XFS in the main kernel.  We (The Sloan Digital Sky Survey) and
> >>many, many other groups here at Fermilab would be very happy to have this in
> >>the main tree.
> >
> >Has XFS been proven to be completely stable
>
> As much as any other filesystem.  "There are no bugs in filesystem XYZ.
> That just means that you have not looked hard enough." :)  There is a
> daily QA suite that XFS is run through.

In the reality the inclusion on XFS in the 2.5 tree would probably move
more peole to use it, and so also to eventually trigger bugs, to report
them, sometimes to fix them.
This way XFS would improve faster, and of course that would be a
good thing.

That said, it is important to
consider the technical reasons to include XFS in 2.5 or not; if this
inclusion could cause some troubles, if XFS fits the requirements
Linus asks for the inclusion and what impact the inclusion would have on
the kernel (Think to JFS as a good example of an easy inclusion, with low
impact).

Luigi

