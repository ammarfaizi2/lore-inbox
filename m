Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263147AbTCSRB4>; Wed, 19 Mar 2003 12:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbTCSRB4>; Wed, 19 Mar 2003 12:01:56 -0500
Received: from AGrenoble-101-1-1-106.abo.wanadoo.fr ([193.251.23.106]:3768
	"EHLO awak") by vger.kernel.org with ESMTP id <S263147AbTCSRBy>;
	Wed, 19 Mar 2003 12:01:54 -0500
Subject: Re: Everything gone!
From: Xavier Bestel <xavier.bestel@free.fr>
To: Eli Carter <eli.carter@inet.com>
Cc: Matthias Schniedermeyer <ms@citd.de>,
       "Richard B. Johnson" <johnson@quark.analogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E78A002.70004@inet.com>
References: <Pine.LNX.4.53.0303191041370.27397@quark.analogic.com>
	 <20030319160437.GA22939@citd.de>
	 <1048091858.989.10.camel@bip.localdomain.fake>  <3E78A002.70004@inet.com>
Content-Type: text/plain; charset=ISO-8859-15
Organization: 
Message-Id: <1048093949.989.13.camel@bip.localdomain.fake>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Mar 2003 18:12:29 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 19/03/2003 à 17:51, Eli Carter a écrit :
> Xavier Bestel wrote:
> > Le mer 19/03/2003 à 17:04, Matthias Schniedermeyer a écrit :
> > 
> > 
> >>rm -rf *
> >>Should do the same(*) but with much better speed.
> >>
> >>Normaly the system should lockup at sometime while doing it.
> >>
> >>
> >>
> >>
> >>*: OK. The version above will "break" in the middle after "/bin/rm" (or
> >>"/lib/libc.so.6") got deleted.
> > 
> > 
> > That would be surprising. Did you actually try it ? :)
> 
> The complex version that you snipped would break because it invokes rm 
> for each file.  The simpler version he gave would not break at that 
> point because it is already running.  Hence the footnote ton the word 
> 'same'.

Aah, yes; I read a bit too fast. *hides*

	Xav

