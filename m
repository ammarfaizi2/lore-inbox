Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271093AbRHOIh4>; Wed, 15 Aug 2001 04:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271095AbRHOIhr>; Wed, 15 Aug 2001 04:37:47 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12806 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271093AbRHOIha>;
	Wed, 15 Aug 2001 04:37:30 -0400
Date: Wed, 15 Aug 2001 05:37:30 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Paul <set@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.8-ac5
In-Reply-To: <20010815031357.O25788@squish.home.loc>
Message-ID: <Pine.LNX.4.33L.0108150532350.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Paul wrote:

> 	Does this include all the 2.4.8 vm mods except
> 'use once' ?  Could you make a brief comment on anything
> signifigant that exists in Linus' tree but not yours?

Alan's kernel has some additions which are not in Linus'
tree, Linus has a few things not in Alan's tree.

I'm currently trying to merge some of the more obviously
right things from -linus to -ac.

In my opinion, use-once is something of which all the
consequences are not quite clear yet, so I don't think
I'll be porting that over.

I will be looking at changes to reduce the impact of
streaming IO further, but don't expect anything to be
merged before its impact is well understood and tested.

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

