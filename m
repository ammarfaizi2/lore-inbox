Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbTCQPuz>; Mon, 17 Mar 2003 10:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261786AbTCQPuz>; Mon, 17 Mar 2003 10:50:55 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:39080 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id <S261784AbTCQPuy>; Mon, 17 Mar 2003 10:50:54 -0500
Date: Mon, 17 Mar 2003 11:01:31 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Paul Albrecht <palbrecht@uswest.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 vm, program load, page faulting, ...
In-Reply-To: <20030317151004.GR20188@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0303171100300.2571-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003, William Lee Irwin III wrote:
> On Sat, 15 Mar 2003, Paul Albrecht wrote:
> >> ... Why does the kernel page fault on text pages, present in the page
> >> cache, when a program starts? Couldn't the pte's for text present in the
> >> page cache be resolved when they're mapped to memory?
> 
> SVR4 did and saw an improvement wrt. page fault rate, according to
> Vahalia.

An improvement in the _page fault rate_, well DUH.

> I'd like to see whether this is useful for Linux.

The question is, does it result in an improvement in the
run speed of processes...

cheers,

Rik

