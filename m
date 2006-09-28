Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWI1K5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWI1K5S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 06:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbWI1K5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 06:57:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:51846 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965308AbWI1K5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 06:57:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Date: Thu, 28 Sep 2006 12:59:24 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, Stefan Seyfried <seife@suse.de>,
       linux-kernel@vger.kernel.org
References: <20060925071338.GD9869@suse.de> <200609270712.34082.rjw@sisk.pl> <20060927232137.GB3305@stusta.de>
In-Reply-To: <20060927232137.GB3305@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609281259.25608.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 28 September 2006 01:21, Adrian Bunk wrote:
> On Wed, Sep 27, 2006 at 07:12:33AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, 27 September 2006 01:39, Adrian Bunk wrote:
> >...
> > > 
> > > Who will track these bugs, debug them (who is e.g. responsible for 
> > > kernel Bugzilla #6035?) and repeatingly poke maintainers to fix such 
> > > issues?
> > > 
> > > If you are saying you will do this job, I can try to redirect such bug 
> > > reports to the kernel Bugzilla, create a "suspend driver problems" meta 
> > > bug there, assign it to you and create the dependencies that it tracks 
> > > the already existing bugs in the kernel Bugzilla.
> > 
> > Yes, please do this.
> > 
> > [I must say I'm a bit afraid of that but anyway someone has to do it ... ;-)]
> 
> OK, thanks.
> 
> I've created #7216, assigned it to you and added Pavel and Nigel to
> the Cc.

Thanks.

> If in doubt I added a bug to the list, so it might contain some false 
> positives.

OK

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
