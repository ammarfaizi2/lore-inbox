Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVA0BxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVA0BxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 20:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVAZXwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:52:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4282 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262253AbVAZUBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 15:01:35 -0500
Date: Wed, 26 Jan 2005 20:01:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050126200127.GA15061@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <20050124175449.GK3515@stusta.de> <20050124213442.GC18933@kroah.com> <20050124214751.GA6396@infradead.org> <20050125060256.GB2061@kroah.com> <20050125195918.460f2b10.khali@linux-fr.org> <20050126003927.189640d4@zanzibar.2ka.mipt.ru> <20050125224051.190b5ff9.khali@linux-fr.org> <20050126013556.247b74bc@zanzibar.2ka.mipt.ru> <20050126101434.GA7897@infradead.org> <20050126131234.A30805@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126131234.A30805@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 01:12:34PM +0000, Russell King wrote:
> On Wed, Jan 26, 2005 at 10:14:34AM +0000, Christoph Hellwig wrote:
> > That's simply not true.  The amount of patches submitted is extremly
> > huge and the reviewers don't have time to look at everythning.
> > 
> > If no one replies it simply means no one has looked at it in enough
> > detail to comment yet.
> 
> How do people get to know this?  Grape vines and crystal balls are
> inherently unreliable.

If someone had looked and considered it good he'd have replied and
said that.  Simple ACK/NACK scheme - if neither returns consider it
lost.

> So, if the community has a problem with enough time to review patches,
> the community must get more (good) patch reviewers.  We can't go around
> blaming the patch submitters for a community failing.

Absolutely.  I think the major problem is that no one pays people for
doing reviews so this is purely a spare-time job.  And that spare time
is limited due to real life issues for most people.

