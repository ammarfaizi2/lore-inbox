Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273176AbRJEUbi>; Fri, 5 Oct 2001 16:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273135AbRJEUb2>; Fri, 5 Oct 2001 16:31:28 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:14291 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S273065AbRJEUbQ>;
	Fri, 5 Oct 2001 16:31:16 -0400
Date: Fri, 5 Oct 2001 22:31:38 +0200 (CEST)
From: Seth Mos <knuffie@xs4all.nl>
To: Rik van Riel <riel@conectiva.com.br>
cc: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.4.33L.0110051721550.26495-100000@duckman.distro.conectiva>
Message-ID: <Pine.BSI.4.10.10110052225300.303-100000@xs3.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Rik van Riel wrote:

> On Fri, 5 Oct 2001, Seth Mos wrote:
> 
> > This happens using either 2.4.10-xfs or 2.4.11-pre3-xfs.
> 
> Ohh duh, IIRC there are a bunch of highmem bugs in
> -linus which are fixed in -ac.

Fitting XFS onto a -ac kernel should be fun :-(

I will try this over the weekend or get a redhat kernel going which is
also -ac based. That would come in handy for other people using XFS since
a lot are using highmem in combination with this fs.

> Can you reproduce the bug with an -ac kernel ?

I am not that good/fast at patching. Expect something over the weekend :-)

Bye
Seth

