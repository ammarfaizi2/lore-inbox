Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUD3LHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUD3LHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 07:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUD3LHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 07:07:13 -0400
Received: from pdbn-d9bb9ef8.pool.mediaWays.net ([217.187.158.248]:44038 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S265134AbUD3LHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 07:07:12 -0400
Date: Fri, 30 Apr 2004 13:07:09 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Symbios and BIOS (was: Re: [PATCH] Blacklist binary-only modules lying about their license)
Message-ID: <20040430110709.GA12131@citd.de>
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <40911C01.80609@techsource.com> <20040429213246.GA15988@valve.mbsi.ca> <40917DBA.1080308@techsource.com> <6DB1DC9C-9A2B-11D8-B83D-000A95BCAC26@linuxant.com> <4091895A.6040800@techsource.com> <20040430060146.GA10826@citd.de> <Pine.GSO.4.58.0404301132140.8585@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0404301132140.8585@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 11:33:20AM +0200, Geert Uytterhoeven wrote:
> On Fri, 30 Apr 2004, Matthias Schniedermeyer wrote:
> > e.g. The symbios(*1)-SCSI-driver only shows devices enabled in its BIOS.
> > This information is stored in a little NVRAM-chip(*2) and the driver
> > uses this data, including bus-speed settings and the like.
> > At least i (had/have*3) trouble with this "feature"!
> 
> So why does my '875 card works fine in my PPC box? No BIOS ever wrote to its
> NVRAM.

sanity-checking prevents the worst failures. And, for this case:
AFAIR the "factory-default" is something like "everything enabled".



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

