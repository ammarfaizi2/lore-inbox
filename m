Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSEaO2s>; Fri, 31 May 2002 10:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315338AbSEaO2r>; Fri, 31 May 2002 10:28:47 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:37284
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S315334AbSEaO2q>; Fri, 31 May 2002 10:28:46 -0400
Date: Fri, 31 May 2002 10:28:35 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Tomas Szepe <szepe@pinerecords.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Skip Ford <skip.ford@verizon.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <20020531134818.GC1905@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0205310958510.23147-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2002, Tomas Szepe wrote:

> With that out, I have to say I've never seen so much talk about
> something as clear. Let's summarize:
> 
> kb25	- is superior to kb24 in one too many aspects
> 	- is next to impossible to split up "unartificially"
> 	- coexists with kb24, which provides for the only conceivable
> 	kind of transition in a change of two greatly diverse systems
> 	- is transparent and well documented
> 	- has been spoken in favor of by celebrities (MOST IMPORTANT!! :D)
> 
> I'd tell you where the problem lies but I like to avoid saying the obvious.

One thing obvious so far is that there were a lot of positive comments
(which is good).  However no one actually tried to produce multiple logical
patches for kbuild25 yet and send them to Linus.  Whether you agree with the
procedure or not is somewhat irrelevant for the final result.  And Daniel
Philips nicely demonstrated how it could be done.


Nicolas

