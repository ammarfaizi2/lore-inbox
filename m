Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWHXIfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWHXIfO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 04:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWHXIfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 04:35:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750868AbWHXIfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 04:35:12 -0400
Subject: Re: Areca arcmsr kernel integration for 2.6.18?
From: Arjan van de Ven <arjan@infradead.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: Greg KH <gregkh@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Theodore Bullock <tbullock@nortel.com>,
       robm@fastmail.fm, brong@fastmail.fm, erich@areca.com.tw, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1156398960.4256.25.camel@thud.gurulabs.com>
References: <00a701c6b2b4$bb564b50$0e00cb0a@robm>
	 <25E284CCA9C9A14B89515B116139A94D0C78805F@zrtphxm0.corp.nortel.com>
	 <20060731200309.bd55c545.akpm@osdl.org>
	 <1154530428.3683.0.camel@mulgrave.il.steeleye.com>
	 <1156375551.4306.10.camel@mentorng.gurulabs.com>
	 <20060824034246.GA18826@suse.de>
	 <1156398960.4256.25.camel@thud.gurulabs.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 24 Aug 2006 10:34:03 +0200
Message-Id: <1156408443.3014.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 23:56 -0600, Dax Kelson wrote:
> On Wed, 2006-08-23 at 20:42 -0700, Greg KH wrote:
> > On Wed, Aug 23, 2006 at 05:25:51PM -0600, Dax Kelson wrote:
> > > On Wed, 2006-08-02 at 10:53 -0400, James Bottomley wrote:
> > > > On Mon, 2006-07-31 at 20:03 -0700, Andrew Morton wrote:
> > > > > > Ok, so how does this go from here into the mainline kernel?
> > > > > 
> > > > > James has moved the driver into the scsi-misc tree, so I assume he has
> > > > > 2.6.19 plans for it.
> > > > 
> > > > Yes, that's the usual path for scsi-misc.
> > > > 
> > > > James
> > > 
> > > It would be great if the arcmsr driver could be included in 2.6.18 so it
> > > can make into all the new distro releases that will be happening the
> > > last 3-4 months of the year.
> > 
> > What distros would that be?  And how do you know that they are going to
> > freeze their kernels at 2.6.18?
> 
> Well, I don't know for sure, but thankfully most distro development is
> pretty transparent.
> 
> The current Fedora Core 6 development (and consequently RHEL5 and
> CentOS5) is using 2.6.18-rc kernels (actually as of yesterday, your git
> tree).

.. and those distros can't pull in this driver because..... ?


