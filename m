Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270604AbRHIWpc>; Thu, 9 Aug 2001 18:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270605AbRHIWpW>; Thu, 9 Aug 2001 18:45:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64010 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270604AbRHIWpJ>; Thu, 9 Aug 2001 18:45:09 -0400
Subject: Re: Swapping for diskless nodes
To: riel@conectiva.com.br (Rik van Riel)
Date: Thu, 9 Aug 2001 23:46:29 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), abali@us.ibm.com (Bulent Abali),
        dws@dirksteinberg.de (Dirk W. Steinberg),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.33L.0108091756420.1439-100000@duckman.distro.conectiva> from "Rik van Riel" at Aug 09, 2001 05:57:10 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UyZR-0008IH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 9 Aug 2001, Alan Cox wrote:
> 
> > Ultimately its an insoluble problem, neither SunOS, Solaris or
> > NetBSD are infallible, they just never fail for any normal
> > situation, and thats good enough for me as a solution
> 
> Memory reservations, with reservations on a per-socket
> basis, can fix the problem.

Only a probabalistic subset of the problem. But yes enough to make it "work"
except where mathematicians and crazy people are concerned. Do not NFS swap
on a BGP4 router with no fixed route to the server..
