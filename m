Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267793AbUGWP0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbUGWP0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267794AbUGWP0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:26:55 -0400
Received: from web52904.mail.yahoo.com ([206.190.39.181]:57753 "HELO
	web52904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267793AbUGWP0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:26:53 -0400
Message-ID: <20040723152421.52282.qmail@web52904.mail.yahoo.com>
Date: Fri, 23 Jul 2004 17:24:21 +0200 (CEST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: A users thoughts on the new dev. model
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <cdr5i3$568$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "H. Peter Anvin" <hpa@zytor.com> a écrit : > Followup to: 
<cdpee5$otu$1@gatekeeper.tmr.com>
> By author:    Bill Davidsen <davidsen@tmr.com>
> In newsgroup: linux.dev.kernel
> 
> Thus:
> 
> 	- Andrew will put experimental patches into -mm;
> 	- Andrew will continue to forward-port 2.6 mainstream fixes
> to
> 	  -mm;
> 	- Patches which have proven themselves stable and useful get
> 	  backported to 2.6;
> 	- If the delta between 2.6 and -mm becomes too great we'll
> 	  consider a hard fork AT THAT TIME, i.e. fork lazily instead
> 	  of the past model of forking eagerly.
> 
> Why the change?  Because the model already has proven itself,
> and
> shown itself to be more functional than what we've had in the
> past.
> 2.6 is probably the most stable mainline tree we've had since
> 1.2 or
> so, and yet Linus and Andrew process *lots* of changes.  The
> -mm tree
> has become a very effective filter for what should go into
> mainline,
> whereas the odd-number forks generally *haven't* been, because
> backporting to mainline has usually been an afterthought.
> 
> I for one welcome our new -mm overlords.
> 
> 	-hpa

Thank you for clarifying this.
So linux 2.6 from kernel.org stay stable.
And 2.6x-mm is like a 2.7 development tree (thought not that 
experimental ;-) )


>From the LWM story i understood that linux will be like windows:
lots of "features" but no stability, except if you use a
 distribution kernel. And that seriously made me think about
 using another free *nix for a stable system.  

Calin

=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.


	

	
		
Vous manquez d’espace pour stocker vos mails ? 
Yahoo! Mail vous offre GRATUITEMENT 100 Mo !
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Le nouveau Yahoo! Messenger est arrivé ! Découvrez toutes les nouveautés pour dialoguer instantanément avec vos amis. A télécharger gratuitement sur http://fr.messenger.yahoo.com
