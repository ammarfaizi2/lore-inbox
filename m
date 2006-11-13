Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933037AbWKMTao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933037AbWKMTao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932960AbWKMTan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:30:43 -0500
Received: from holoclan.de ([62.75.158.126]:932 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S933037AbWKMTam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:30:42 -0500
Date: Mon, 13 Nov 2006 20:27:38 +0100
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: paging request BUG in 2.6.19-rc5 on resume - X60s
Message-ID: <20061113192738.GE7942@gimli>
Mail-Followup-To: linux-thinkpad@linux-thinkpad.org,
	linux-kernel@vger.kernel.org
References: <20061113081147.GB5289@gimli> <200611131537.01626.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611131537.01626.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Mon, Nov 13, 2006 at 03:37:01PM +0100, Rafael J.
	Wysocki wrote: > On Monday, 13 November 2006 09:11, Martin Lorenz wrote:
	> > Hallo again, > > > > here is another one: > > > > I reported a black
	screen on resume with my latest kernel build earlyer. But > > this was
	not reproducible. Only occured once. > > Is this a resume from disk? If
	so, which kernel are you using? > [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 03:37:01PM +0100, Rafael J. Wysocki wrote:
> On Monday, 13 November 2006 09:11, Martin Lorenz wrote:
> > Hallo again,
> > 
> > here is another one:
> > 
> > I reported a black screen on resume with my latest kernel build earlyer. But
> > this was not reproducible. Only occured once.
> 
> Is this a resume from disk?  If so, which kernel are you using?
> 

no from suspend to ram

Linux gimli 2.6.19-rc5+ieee80211+e1000-45.3+1909-g6a4abeae-dirty #1 SMP Wed
Nov 8 20:14:31 CET 2006 i686 GNU/Linux


gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
