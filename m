Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262794AbSJLDtn>; Fri, 11 Oct 2002 23:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262795AbSJLDtm>; Fri, 11 Oct 2002 23:49:42 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:44977 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262794AbSJLDtm>; Fri, 11 Oct 2002 23:49:42 -0400
Date: Sat, 12 Oct 2002 00:55:08 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "David S. Miller" <davem@redhat.com>
cc: haveblue@us.ibm.com, <linux-kernel@vger.kernel.org>
Subject: Re: [lart] /bin/ps output
In-Reply-To: <20021011.203806.38715834.davem@redhat.com>
Message-ID: <Pine.LNX.4.44L.0210120054030.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2002, David S. Miller wrote:

	[ 8 gazillion kernel threads ]

> We could make them threads of process 0 :-)

That was my first thought too, but on second thought I think we've
got an excessive amount of kernel threads and should do something
about that...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

