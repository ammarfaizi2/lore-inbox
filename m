Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbSJYRBD>; Fri, 25 Oct 2002 13:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSJYRBC>; Fri, 25 Oct 2002 13:01:02 -0400
Received: from 1-116.ctame701-1.telepar.net.br ([200.181.137.116]:10939 "EHLO
	1-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261490AbSJYRBC>; Fri, 25 Oct 2002 13:01:02 -0400
Date: Fri, 25 Oct 2002 15:07:01 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Paul Larson <plars@linuxtestproject.org>
cc: Andrew Morton <akpm@digeo.com>, <chrisl@vmware.com>,
       Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       <chrisl@gnuchina.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
In-Reply-To: <1035562304.5646.171.camel@plars>
Message-ID: <Pine.LNX.4.44L.0210251506350.1995-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Oct 2002, Paul Larson wrote:
> On Thu, 2002-10-24 at 16:29, Andrew Morton wrote:
> > http://mail.nl.linux.org/linux-mm/2002-08/msg00049.html
> Is it the 2.4 or 2.5 (or both) ac kernels that have the per zone lru?
> I have some stuff I'd like to try with that.

2.4-rmap
2.4-ac
2.5 all

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

