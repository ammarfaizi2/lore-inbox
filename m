Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265032AbSJWOvM>; Wed, 23 Oct 2002 10:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265033AbSJWOvM>; Wed, 23 Oct 2002 10:51:12 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:45006 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265032AbSJWOvL>; Wed, 23 Oct 2002 10:51:11 -0400
Date: Wed, 23 Oct 2002 12:56:49 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: bert hubert <ahu@ds9a.nl>
cc: akpm@digeo.com, <linux-kernel@vger.kernel.org>, <albert@users.sf.net>
Subject: Re: 2.5.44 io accounting weirdness, bi & bo swapped?
In-Reply-To: <20021023124819.GA32421@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44L.0210231256090.28073-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, bert hubert wrote:

> Is not. Touching a page entails reading it. In Albert's procps with 2.5.44,
> bi and bo are reversed. Rik's vmstat does report things correctly.

> Perhaps Albert's procps isn't ready for 2.5.44?

I suspect it's just a simple typo somewhere. Maybe Albert can't
run 2.5 on his computer so he didn't get around to testing ?

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

