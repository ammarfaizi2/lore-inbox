Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbRERXKK>; Fri, 18 May 2001 19:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbRERXJ7>; Fri, 18 May 2001 19:09:59 -0400
Received: from [203.36.158.121] ([203.36.158.121]:15364 "EHLO
	piro.kabuki.openfridge.net") by vger.kernel.org with ESMTP
	id <S261599AbRERXJs>; Fri, 18 May 2001 19:09:48 -0400
Date: Sat, 19 May 2001 09:09:39 +1000
From: Daniel Stone <daniel@kabuki.openfridge.net>
To: mirabilos <eccesys@topmail.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CML 1 is ok
Message-ID: <20010519090939.A675@kabuki.openfridge.net>
Mail-Followup-To: mirabilos <eccesys@topmail.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010518220028.B139BA5AD65@www.topmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010518220028.B139BA5AD65@www.topmail.de>; from eccesys@topmail.de on Sat, May 19, 2001 at 12:00:28AM +0200
Organisation: Sadly lacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 12:00:28AM +0200, mirabilos wrote:
> netfilter: I _liked_ ipfwadm
> because I hate to always re-learn when a new kernel comes out.

Netfilter is going to stay. Rusty knew from early on in ipchains development
that the whole concept was wrong, but Alan told him to continue on, get it
into 2.2, and then do a new one for 2.4. There's a document detailing this
somewhere, I just can't forget where.

> our company will soon ship a product still using ipfwadm (I
> started with 2.0.33, going to .36 and 2.4.0-testX).
> It's a pity this M$ism to not support it forever (they just
> stopped supporting DOS! and GW-BASIC *snief*)

This is entirely incorrect and FUD. If enable Netfilter, look in the
Netfilter options, disable conntrack and IP tables support, you have
(*gasp!*) ipchains compatability, as well as (*ohmygod!*) ipfwadm
compatability.
 
> -mirabilos
> 
> PS: Don't answer plz as I'll be offline for a time.
>     _And_ I mean this honest, even it might considered sp.m

The FUD has to be corrected.

-- 
Daniel Stone
daniel@kabuki.openfridge.net
