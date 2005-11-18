Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbVKRRkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVKRRkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbVKRRkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:40:00 -0500
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:50151 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S1030260AbVKRRj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:39:59 -0500
Date: Fri, 18 Nov 2005 18:41:50 +0100
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051118174150.GA12640@finwe.eu.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116191051.GG2193@spitz.ucw.cz> <20051117165437.GA10402@dspnet.fr.eu.org> <20051117164451.GA27178@kroah.com> <20051117201509.GA25250@finwe.eu.org> <20051117215612.GA8797@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117215612.GA8797@kroah.com>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote;

> > > > > What unstable implementation? swsusp had very little regressions over past
> > > > > year or so. Drivers were different story, but nothing changes w.r.t. drivers.
> > > > Do you mean swsusp is actually supposed to work?  Suspend-to-ram,
> > > > suspend-to-disk or both?
> > > Both.  -to-ram depends on your video chip, but to-disk should work just
> > > fine.  If not, please report bugs.
> > Thanks, I've just realized, that I probably forgot to CC anyone last time... 
> > :)
> > So, may I kindly ask to look on:
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0511.1/1863.html ?
> Care to file this in bugzilla.kernel.org and assign it to Pavel?

Sure :)

http://bugzilla.kernel.org/show_bug.cgi?id=5626

Thanks


-- 
Jacek Kawa
