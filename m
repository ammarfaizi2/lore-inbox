Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265128AbUFRMS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbUFRMS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 08:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265130AbUFRMS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 08:18:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:61645 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265128AbUFRMS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 08:18:56 -0400
Date: Fri, 18 Jun 2004 14:18:13 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <ft01@webmastery.com.au>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Matt Mackall <mpm@selenic.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Subject: Re: make checkstack on m68k
Message-ID: <20040618121813.GB18258@wohnheim.fh-wedel.de>
References: <200406161930.VAA16618@pfultra.phil.uni-sb.de> <Pine.LNX.4.58.0406171812440.8197@bonkers.disegno.com.au> <20040617183616.GC29029@wohnheim.fh-wedel.de> <Pine.GSO.4.58.0406172127150.1495@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.58.0406172127150.1495@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 June 2004 21:27:35 +0200, Geert Uytterhoeven wrote:
> On Thu, 17 Jun 2004, [iso-8859-1] Jörn Engel wrote:
> >
> > It's not as ugly as my hack.  Can I get a success report from m68k?
> > Thanks!

Good.  Finn, can you resend to me with a signed-off-by: comment?  If
you grow bored, you could seperate the i386 regexes (sub..., add...)
as well.

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens
