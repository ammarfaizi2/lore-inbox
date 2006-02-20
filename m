Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWBTBVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWBTBVa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 20:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWBTBVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 20:21:30 -0500
Received: from smtp102.his.com ([216.194.200.182]:36551 "EHLO smtp102.his.com")
	by vger.kernel.org with ESMTP id S932502AbWBTBV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 20:21:29 -0500
Date: Sun, 19 Feb 2006 20:20:49 -0500 (EST)
From: Thomas Dickey <dickey@his.com>
To: Adam Tla/lka <atlka@pg.gda.pl>
cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>, torvalds@osdl.org,
       Ncurses Mailing List <bug-ncurses@gnu.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
In-Reply-To: <20060219114736.GD862@sunrise.pg.gda.pl>
Message-ID: <20060219201811.D62691@mail101.his.com>
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <43F72C7A.8010709@ums.usu.ru>
 <20060218204407.L36972@mail101.his.com> <20060219114736.GD862@sunrise.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2006, Adam Tla/lka wrote:

> On Sat, Feb 18, 2006 at 08:53:38PM -0500, Thomas Dickey wrote: OK but my 
> fix is for all not only curses programs. Anyway from my point of view 
> programs should be written in a way so they are easy to use and work 
> correctly without user special intervention and knowledge. So ncurses 
> hack is not

of course (which is why I have xterm doing the same thing).

> a desired way IMHO. Generally saying products should be designed with 
> customers comfort and not developers/producers comfort in mind. But this 
> is just a wish of course in current world and off topic.

;-)

-- 
Thomas E. Dickey
http://invisible-island.net
ftp://invisible-island.net
