Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbTJWSrf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 14:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbTJWSrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 14:47:35 -0400
Received: from dslb138.fsr.net ([12.7.7.138]:46747 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S261648AbTJWSrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 14:47:32 -0400
Message-ID: <1066934851.3f982243bc9a8@horde.sandall.us>
Date: Thu, 23 Oct 2003 18:47:31 +0000
From: Eric Sandall <eric@sandall.us>
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: srfs - a new file system.
References: <Pine.LNX.4.44_heb2.09.0310201031150.20172-100000@nexus.cs.bgu.ac.il>  <1066683638.3f944cf6e6763@horde.sandall.us> <1066907220.1686.22.camel@sonja>
In-Reply-To: <1066907220.1686.22.camel@sonja>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 134.121.190.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Egger <degger@fhm.edu>:
> The last time I looked Coda was a horrible mess of a code, closely
> impossible to get it compile let alone configure and it seems to have
> the same interoperability problems like intermezzo i.e. it didn't work
> between i386<->powerpc. I haven't looked at Lustre light or srfs yet but
> I certainly welcome any fresh projects in the area of distributed or
> replicating filesystems.
> 
> -- 
> Servus,
>        Daniel

Agreed, more DFS' are always good.  As for Coda, it has compiled fine for me for
the last year (with some bison patches), but I have not actually tried it yet. 
NFS may be slow, but at least it works and I haven't lost any files due to
using it.

-sandalle

-- 
PGP Key Fingerprint:  FCFF 26A1 BE21 08F4 BB91  FAED 1D7B 7D74 A8EF DD61
http://search.keyserver.net:11371/pks/lookup?op=get&search=0xA8EFDD61

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/E/IT$ d-- s++:+>: a-- C++(+++) BL++++VIS>$ P+(++) L+++ E-(---) W++ N+@ o?
K? w++++>-- O M-@ V-- PS+(+++) PE(-) Y++(+) PGP++(+) t+() 5++ X(+) R+(++)
tv(--)b++(+++) DI+@ D++(+++) G>+++ e>+++ h---(++) r++ y+
------END GEEK CODE BLOCK------

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
