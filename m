Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTGXKz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 06:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTGXKz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 06:55:28 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:61650 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261874AbTGXKz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 06:55:27 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16159.48809.812634.455756@laputa.namesys.com>
Date: Thu, 24 Jul 2003 15:10:33 +0400
To: Shawn <core@enodev.com>
Cc: Tupshin Harper <tupshin@tupshin.com>, Hans Reiser <reiser@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
In-Reply-To: <1059024090.9728.22.camel@localhost>
References: <3F1EF7DB.2010805@namesys.com>
	<3F1F6005.4060307@tupshin.com>
	<1059021113.7911.13.camel@localhost>
	<3F1F66F0.1050406@tupshin.com>
	<1059024090.9728.22.camel@localhost>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn writes:
 > Looks like the 2.5.74 is the last one of any respectable size. I'm
 > thinking someone forgot a diff switch (N?) over at namesys...
 > 
 > Hans? Time to long-distance spank someone?

Can you try following the instructions on the
http://www.namesys.com/code.html (requires bitkeeper)?

Nikita.

 > 
 > On Wed, 2003-07-23 at 23:56, Tupshin Harper wrote:
 > > Shawn wrote:
 > > 
 > > >This is pretty f'ed, but it's on ftp://ftp.namesys.com/pub/tmp
 > > >
 > > Thanks, but I tried applying the
 > > 2.6.0-test1-reiser4-2.6.0-test1.diff from that location with a lack of 
 > > success.
 > > 
 > > It applied cleanly, but it doesn't add a fs/reiser4 directory and 
 > > asociated contents. Is there an additional patch, or is this one broken?
 > > 
 > > -Tupshin
 > > 
