Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751853AbWIGUfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbWIGUfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 16:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWIGUfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 16:35:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:30343 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751853AbWIGUfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 16:35:02 -0400
Date: Thu, 7 Sep 2006 13:34:26 -0700
From: Greg KH <gregkh@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [patch 37/37] sky2: version 1.6.1
Message-ID: <20060907203426.GB556@suse.de>
References: <20060906224631.999046890@quad.kroah.org> <20060906225812.GL15922@kroah.com> <20060907192528.GG8793@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907192528.GG8793@ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 07:25:28PM +0000, Pavel Machek wrote:
> On Wed 06-09-06 15:58:12, Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> > 
> > ------------------
> > From: Stephen Hemminger <shemminger@osdl.org>
> > 
> > Since this code incorporates some of the fixes from 2.6.18, change
> > the version number.
> > 
> > Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Not sure, one of 'stable' criteria is 'fixes bad bug'. What bug does
> this fix?

The previous 5 patches changed this driver, so changing the version
number of it is acceptable to me.

thanks,

greg k-h
