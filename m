Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271378AbTGWWyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271379AbTGWWyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:54:13 -0400
Received: from u195-95-86-34.dialup.planetinternet.be ([195.95.86.34]:15620
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP id S271378AbTGWWyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:54:11 -0400
Message-Id: <200307232305.h6NN5cKH027682@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: nick black <dank@suburbanjihad.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC 
In-Reply-To: Your message of "Mon, 21 Jul 2003 16:02:27 EDT."
             <20030721200227.GA789@suburbanjihad.net> 
Date: Thu, 24 Jul 2003 01:05:38 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetz,

> > In this case, does it happen if you exit X, or only if you are switching
> > to the console while X are active? If it happens only in second case, then
> > it is bug (I believe fixed long ago) in XFree mga driver: it was sometime
>
> it is the latter case, thanks for the info!  regardless, the 2.6.0-test1
> problems continue; i'll update my x this evening if my version doesn't
> contain the fix.

After reading this, I enthousiastically upgraded from Xfree 4.2.0 to 
4.3.0, but nothing changed. :-( The problem is indeed X-related, but 
refuses to go away after the upgrade.

Also, I've had 4.2.0 and several earlier X versions working just fine
with the "old" matroxfb in the same setup that I'm using now. Was there 
a bug workaround for this issue in the old driver? If so, is there any
hope of it returning?

MCE
