Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTJWMet (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 08:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTJWMet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 08:34:49 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:10112 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S263561AbTJWMes
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 08:34:48 -0400
Date: Thu, 23 Oct 2003 14:34:46 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8, oops, [__remove_from_page_cache+36/112] __remove_from_page_cache+0x24/0x70
Message-ID: <20031023123446.GA4515@finwe.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031022084413.GA2773@finwe.eu.org> <20031022085611.GA1848@finwe.eu.org> <20031022111427.GL2617@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031022111427.GL2617@rdlg.net>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:

> > > This machine has new RAM, but after about 7 hours of testing, 
> > > memtest.86 didn't show any errors... 
> > Well, it's RAM anyway... I've just got few segfaults in vim...
> This sounds like what mine was doing, the oops looked similar as well
> (with the null pointer part atleast).  Reboot and I bet it'll run fine
> for a while and then start up again.  For me it seemed to start faulting
> when "free" showed over 250 Megs used.

In next run memtest found some errors (after nine hours though ;) 

So hardware, not Linux. :)

bye

-- 
Jacek Kawa 
