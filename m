Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTDNShx (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbTDNSfX (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:35:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:530 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263720AbTDNSfH (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:35:07 -0400
Date: Mon, 14 Apr 2003 10:29:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Bradford <john@grabjohn.com>
cc: vda@port.imtp.ilyichevsk.odessa.ua,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-English user messages
In-Reply-To: <200304141255.h3ECtcFn000432@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0304141024250.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Apr 2003, John Bradford wrote:
> 
> Anybody who doesn't document their code is wasting an opportunity to
> improve their work.

Some people care about documentation, some people don't. That's a fact,
and spouting platitudes about "improving their work" just doesn't
_matter_. The whole open source idea is that people do what they care 
about and what they are good at, and exactly because they aren't forced to 
deal with issues they don't have a heart for they take  more pride and 
interest in the stuff they _do_ do.

Personally, I don't write documentation. I don't much even write comments
in my code. My personal feeling is that as long as functions are small and
readable (and logical), and global variables have good names, that's all I
need to do. Others - who do care about comments and docs - can do that
part.

And you know what? That _lack_ of comments and documantation improves my 
work. Not because documentation is bad, but because I DO NOT CARE. So I 
concentrate on the stuff I do care about.

So no, people are _NOT_ "wasting an opportunity". 

			Linus

