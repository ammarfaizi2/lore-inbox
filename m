Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSIZQMZ>; Thu, 26 Sep 2002 12:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbSIZQMZ>; Thu, 26 Sep 2002 12:12:25 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:41888
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S261411AbSIZQMZ>; Thu, 26 Sep 2002 12:12:25 -0400
Date: Thu, 26 Sep 2002 12:17:09 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Thunder from the hill <thunder@lightweight.ods.org>
cc: Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2.5] Single linked lists for Linux,v2
In-Reply-To: <Pine.LNX.4.44.0209260934170.7827-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0209261216420.3548-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Thunder from the hill wrote:

> Hi,
> 
> On Thu, 26 Sep 2002, Rik van Riel wrote:
> > If I were you, I'd take a large piece of paper and make
> > a drawing of what the data structure looks like and what
> > the various macros/functions are supposed to do.
> 
> Well, I know what they _should_ do. But I don't know what I should 
> initialize an empty list entry to. That's not got much spam in it...

Try with NULL.


Nicolas

