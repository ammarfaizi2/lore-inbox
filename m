Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbUJXDi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbUJXDi3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 23:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUJXDi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 23:38:29 -0400
Received: from pdb9-d9bb9339.pool.mediaWays.net ([217.187.147.57]:59142 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S261365AbUJXD3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 23:29:07 -0400
Date: Sun, 24 Oct 2004 05:29:02 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Stephen Frost <sfrost@snowman.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
Message-ID: <20041024032902.GA19696@citd.de>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041022234631.GF28904@waste.org> <20041023011549.GK17038@holomorphy.com> <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org> <20041023154128.GP12780@ns.snowman.net> <20041023215152.GA17596@citd.de> <20041024000221.GQ12780@ns.snowman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024000221.GQ12780@ns.snowman.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.2004 20:02, Stephen Frost wrote:
> * Matthias Schniedermeyer (ms@citd.de) wrote:
> > On 23.10.2004 11:41, Stephen Frost wrote:
> > > * Linus Torvalds (torvalds@osdl.org) wrote:
> > > > However, for some reason four numbers just looks visually too obnoxious to
> > > 
> > > I agree, four numbers is *very* obnoxious, I mean, really, if for no
> > > other reason than *Oracle* uses four numbers. :)
> > 
> > Actually Oracle uses (or at least displays) 5 numbers. :-)
> > 
> > e.g. The version currently in use where i work: 9.2.0.5.0
> 
> Eh, their directory structure is (or at least, was last I checked) based
> off of four numbers.
> 
> ie: /oracle/9.2.0.1

The directory is a "user-supplied" value. AFAIR (last time i installed
an oracle-client myself is about 2 years ago (i never had to install a
server)) the "default" is/was something like: /oracle/OraHome1

My DBA collegues use a default of first 3 numbers without delimiters
ie: /server/oracle/920

When i connect to a server with sqlplus i get this:

- snip -
Connected to:
Oracle9i Release 9.2.0.5.0 - 64bit Production
JServer Release 9.2.0.5.0 - Production
- snip -

Oracle shows 5 numbers.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

