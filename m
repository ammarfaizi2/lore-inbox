Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318934AbSHSRFT>; Mon, 19 Aug 2002 13:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318937AbSHSRFS>; Mon, 19 Aug 2002 13:05:18 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:3603 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S318934AbSHSRFS>;
	Mon, 19 Aug 2002 13:05:18 -0400
Date: Mon, 19 Aug 2002 19:09:07 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020819170907.GB25502@alpha.home.local>
References: <20020817181624.GM10730@lug-owl.de> <1029765431.32209.77.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029765431.32209.77.camel@dlacoste.ottawa.loran.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 09:57:11AM -0400, Dana Lacoste wrote:
> Why do we need to maintain compatibility
> with OLD (not 'low-end' but OLD) hardware if there's an existing
> kernel that meets that hardware's needs already?
 
because we always need new features, even on older hardware. If 2.4 didn't
support my 386sx, I would have had to either port iptables, cramfs, pppoe
and such things to 2.0 (or 2.2), or replace this solid-state, silent box
with a new, noisy and power hungry one. I'm really happy that this box is
still supported and hope it will still run 2.6.

Cheers,
Willy

