Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbSKRXOg>; Mon, 18 Nov 2002 18:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265321AbSKRXOY>; Mon, 18 Nov 2002 18:14:24 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:4804 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265320AbSKRXN5>; Mon, 18 Nov 2002 18:13:57 -0500
Date: Mon, 18 Nov 2002 21:20:43 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: deepak <dxbadami@wichita.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: patch
In-Reply-To: <3DD66292@webmail.wichita.edu>
Message-ID: <Pine.LNX.4.44L.0211182119470.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, deepak wrote:

> how do i uninstall a patch

$ man patch
...
       -R  or  --reverse
          Assume that this patch was created with the old and new
          files swapped.  (Yes, I'm afraid that does happen occa­
          sionally,  human  nature  being  what  it  is.)   patch
          attempts  to  swap each hunk around before applying it.
          Rejects come out in the swapped format.  The -R  option
	  ...

Next time you should read the man page yourself ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

