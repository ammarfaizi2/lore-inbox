Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286871AbSAIOHA>; Wed, 9 Jan 2002 09:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSAIOFa>; Wed, 9 Jan 2002 09:05:30 -0500
Received: from mustard.heime.net ([194.234.65.222]:42444 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S286692AbSAIOFS>; Wed, 9 Jan 2002 09:05:18 -0500
Date: Wed, 9 Jan 2002 15:05:06 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Error reading multiple large files
In-Reply-To: <Pine.LNX.4.33L.0201091201330.2985-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.30.0201091504350.7021-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've done a little bit of low memory testing with my -rmap
> VM patch, the system seems to be working just fine with 8MB
> of RAM ...
>
> If you have the time, could you try the following patch ?
>
> 	http://surriel.com/patches/2.4/2.4.17-rmap-11a

Do you think this is the case? I've 1GB memory in the box (no highmem)

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

