Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261974AbSIYNIP>; Wed, 25 Sep 2002 09:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSIYNIP>; Wed, 25 Sep 2002 09:08:15 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:27569 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261974AbSIYNIP>; Wed, 25 Sep 2002 09:08:15 -0400
Date: Wed, 25 Sep 2002 10:13:03 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Adam Goldstein <Whitewlf@Whitewlf.net>
cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
       <linux-kernel@vger.kernel.org>, Adam Taylor <iris@servercity.com>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
In-Reply-To: <EFED8A1D-D02F-11D6-AD2E-000502C90EA3@Whitewlf.net>
Message-ID: <Pine.LNX.4.44L.0209251012160.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Adam Goldstein wrote:

> These are under current load, i will run a full snap of tests tomorrow
> during peak load.

> 235 processes: 229 sleeping, 6 running, 0 zombie, 0 stopped
> CPU0 states: 87.5% user, 12.0% system,  0.0% nice,  0.0% idle
> CPU1 states: 90.2% user,  9.4% system,  0.0% nice,  0.0% idle

OK, this looks like you're just running out of CPU power.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

