Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269914AbRHEEWQ>; Sun, 5 Aug 2001 00:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269912AbRHEEWH>; Sun, 5 Aug 2001 00:22:07 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:40778 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S269914AbRHEEV4>; Sun, 5 Aug 2001 00:21:56 -0400
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Black <mblack@csihq.com>, Ben LaHaise <bcrl@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <andrewm@uow.edu.au>
In-Reply-To: <Pine.LNX.4.33.0108040952460.1203-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108040952460.1203-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 05 Aug 2001 00:19:43 -0400
Message-Id: <996985193.982.7.camel@gromit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Aug 2001 10:08:56 -0700, Linus Torvalds wrote:
> 
> On Sat, 4 Aug 2001, Mike Black wrote:
> >
> > I'm testing 2.4.8-pre4 -- MUCH better interactivity behavior now.
> 
> Good.. However.. [...]  before we get too happy about the interactive thing, let's
> remember that sometimes interactivity comes at the expense of throughput,
> and maybe if we fix the throughput we'll be back where we started.

Could there be both interactive and throughput optimizations, and a way
to choose one or the other at run-time? Or even just at compile time? 

