Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbTATVdW>; Mon, 20 Jan 2003 16:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbTATVdW>; Mon, 20 Jan 2003 16:33:22 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:36996 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267005AbTATVdV>; Mon, 20 Jan 2003 16:33:21 -0500
Date: Mon, 20 Jan 2003 19:41:58 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: David Schwartz <davids@webmaster.com>
cc: david.lang@digitalinsight.com, "" <dana.lacoste@peregrine.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: Is the BitKeeper network protocol documented?
In-Reply-To: <20030120201904.AAA25148@shell.webmaster.com@whenever>
Message-ID: <Pine.LNX.4.50L.0301201940200.18171-100000@imladris.surriel.com>
References: <20030120201904.AAA25148@shell.webmaster.com@whenever>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003, David Schwartz wrote:

> 	I submit that it is impossible to comply with the GPL and
> distribute binaries if the preferred form of a work for the purposes of
> making modifications to it is in a proprietary file format. This is
> tantamount to encrypting the source.

You'll have to find another project to prove your idea, though.

Bitkeeper is using the AT&T SCCS format (plus compression) to
store its data and metadata.  People are working on scripts to
extract the source from a bitkeeper tree without using the
bitkeeper software.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
