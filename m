Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030562AbVLWPlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbVLWPlD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 10:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbVLWPlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 10:41:03 -0500
Received: from lizards-lair.paranoiacs.org ([216.158.28.252]:15063 "EHLO
	lizards-lair.paranoiacs.org") by vger.kernel.org with ESMTP
	id S1030562AbVLWPlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 10:41:00 -0500
Date: Fri, 23 Dec 2005 10:35:41 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, legal@lists.gnumonks.org,
       linux-fsdevel@vger.kernel.org,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       "Robert W. Fuller" <garbageout@sbcglobal.net>
Subject: Re: blatant GPL violation of ext2 and reiserfs filesystem drivers
Message-ID: <20051223153541.GA13111@paranoiacs.org>
References: <43AACF77.9020206@sbcglobal.net> <496FC071-3999-4E23-B1A2-1503DCAB65C0@mac.com> <1135283241.12761.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135283241.12761.19.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005 15:27:21 -0500, Steven Rostedt wrote:
> On Thu, 2005-12-22 at 13:01 -0500, Kyle Moffett wrote:
> > On Dec 22, 2005, at 11:08, Robert W. Fuller wrote:
> > > Please see the following thread:
> > >
> > > http://www.opensolaris.org/jive/thread.jspa?threadID=2132&tstart=0x
> > >
> > > Sorry I didn't get around to reporting this sooner, but at least  
> > > the guilty party has had plenty of time to fail to repent.
> > >
> > > Regards,
> > >
> > > Rob
> > 
> > This case looks about as black and white as it gets (although IANAL),  
> > so I'm adding gpl-violations.org-legal to the CC list.
> 
> I'm not sure this is the case here or not, but it definitely brings up
> an interesting question.

It isn't the case here. (Tho' your question is interesting.)

The case here appears to be:

* Crossmeta offers "add-on" software as a free download from their web
  site: <URL:http://www.crossmeta.com/downloads/crossmeta-add-1_0.zip>.
  The zip file contains a text file gpl-license.txt, which says that the
  add-ons are offered under the terms of the GPL.

* User downloads this GPLed software and asks the developer to provide
  source code. Developer replies that the source code will be provided
  only to paying customers:
  <URL:http://www.opensolaris.org/jive/message.jspa?messageID=12277#12277>.

That's baad, m'kay?

-- 
Ben Slusky                      | As if you could kill time
sluskyb@paranoiacs.org          | without injuring eternity.
sluskyb@stwing.org              |               -Paula Baker
PGP keyID ADA44B3B      

