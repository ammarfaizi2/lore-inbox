Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbSKUCKB>; Wed, 20 Nov 2002 21:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSKUCKB>; Wed, 20 Nov 2002 21:10:01 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:22713 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S266296AbSKUCKB>; Wed, 20 Nov 2002 21:10:01 -0500
Date: Thu, 21 Nov 2002 00:16:53 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Mark Atwood <mra@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to invalidate the filesystem buffer cache?
In-Reply-To: <m365urfzat.fsf@marka.linux.digeo.com>
Message-ID: <Pine.LNX.4.44L.0211210016420.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov 2002, Mark Atwood wrote:

> Like the question says, is there a way to invalidate the whole buffer
> cache at once?

Except for unmounting all filesystems, no.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

