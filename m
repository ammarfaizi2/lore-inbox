Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUIHI5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUIHI5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 04:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUIHI5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 04:57:50 -0400
Received: from schiffbauer.net ([212.112.227.138]:45243 "EHLO
	pluto.schiffbauer.net") by vger.kernel.org with ESMTP
	id S268955AbUIHI5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 04:57:38 -0400
Date: Wed, 8 Sep 2004 02:11:40 +0200
From: Marc Schiffbauer <marc@schiffbauer.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NETWORK broken at least for 2.6.8.1 and 2.6.9-rc1
Message-ID: <20040908001140.GC31868@lisa>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <413E4A7D.8010401@esoterica.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413E4A7D.8010401@esoterica.pt>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.20-hpt i686
X-Editor: vim 6.1.018-1
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paulo da Silva schrieb am 08.09.04 um 01:55 Uhr:
> Hi:
> 
> For almost all sites I cannot download using wget or ftp for example.
> I can comunicate between two PCs using ssh and rsync however.
> ping and traceroute also work fine.
> I discovered this problem because I was unable to fetch any
> file when using "emerge -f".
> I tried with k 2.6.7 with exactly the same configuration and it works!
> 
> I am using gentoo in a laptop Compaq presario 2541EA.
> The module is natsemi.c. I tried to copy this file from 2.6.7 into
> 2.6.9-rc1 and recompile the kernel without any success.
> The problem still remains.
> If any further information is need, pls. email me.
> Thank you.

This describes your problem:

http://lwn.net/Articles/92727/

-Marc
-- 
+-O . . . o . . . O . . . o . . . O . . .  ___  . . . O . . . o .-+
| Ein Service von Links2Linux.de:         /  o\   RPMs for SuSE   |
| --> PackMan! <-- naeheres unter        |   __|   and  others    |
| http://packman.links2linux.de/ . . . O  \__\  . . . O . . . O . |
