Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286381AbRLTVOz>; Thu, 20 Dec 2001 16:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286384AbRLTVOq>; Thu, 20 Dec 2001 16:14:46 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:15746 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S286383AbRLTVOd>; Thu, 20 Dec 2001 16:14:33 -0500
Date: Thu, 20 Dec 2001 22:14:22 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Message-ID: <20011220211422.GS7414@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <20011220203223.GO7414@vega.digitel2002.hu> <Pine.LNX.3.95.1011220155155.8609A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1011220155155.8609A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: vega Linux 2.4.16 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 04:05:26PM -0500, Richard B. Johnson wrote:
> One of the many bad things about changing this kind of stuff is that
> it doesn't even follow the rules, i.e., upper case is used for proper
> names an/or where there could be a conflict between a previously-defined
> abbreviation such as milliampere and megampere (mA, MA). Instead, most

OK, that's true, 'MA' is a nightmare even for the first sight ...

> everybody uses K for kilo and it's as absolutely incorrect as possible.
> The existing symbols work by fiat. You can't make them "correct" by
> following incorrect rules.

Oh well, sorry, so let's say about 'k' and 'm'. However an engineer friend
of mine has just say that 'K' is 1024, and 'k' is 1000 ... I dunno anymore ...
[however I've never seen 'Kg' instead of 'kg', but 'mB' or 'mb' are ugly
when compared with 'Mb' and 'MB', not counting that 'b' is bit and 'B' is
byte ... well ... it's confusing sometimes ...]

> 2 ^ 0  =  p    (1)
> 2 ^ 1  =  dp   dipenguin
> 2 ^ 2  =  qp   hepenguin

Nice ;-)

Sorry for OT, I'm going to convert myself into private mails when somebody
will reply ...

- Gabor
