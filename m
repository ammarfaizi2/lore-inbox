Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbSIWU4E>; Mon, 23 Sep 2002 16:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSIWU4E>; Mon, 23 Sep 2002 16:56:04 -0400
Received: from 44.231.186.195.dial.bluewin.ch ([195.186.231.44]:913 "EHLO
	k3.hellgate.ch") by vger.kernel.org with ESMTP id <S261382AbSIWU4D>;
	Mon, 23 Sep 2002 16:56:03 -0400
Date: Mon, 23 Sep 2002 23:01:12 +0200
From: Roger Luethi <rl@hellgate.ch>
To: svetljo <svetljo@lycos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-rhine, VT6103 and VT8235
Message-ID: <20020923210112.GA423@k3.hellgate.ch>
Mail-Followup-To: svetljo <svetljo@lycos.com>,
	linux-kernel@vger.kernel.org
References: <JOGPEBMEIODLJAAA@mailcity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JOGPEBMEIODLJAAA@mailcity.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.20-pre5 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002 20:17:38 +0100, svetljo wrote:
> Hi just found previous report about my troubles
> dating 2002-07-20
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102718248323184&w=2
> 
> ETDEV WATCHDOG: eth1: transmit timed out
> eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
[...]
> mobo EPoX 8K5A-3+ KT333 + VT8235 2.4.19-pre10jam3(with/without the fix) 
> couldn't find 2.4.20-pre7 with SGI's xfs :( to test

Beautiful. Now that the regular Rhine chips seem to work it's all those VIA
wonder south bridges. I'm currently swamped with work but I'll hopefully
have a driver with additional fixes ready in a two or three weeks time
frame (unless somebody beats me to it).

> so i wanted to ask whether someone has it working
> and if there is a newer fix? :)

The VT823x are still a problem. I added your report to my list. Thx.

Roger
