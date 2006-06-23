Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752064AbWFWVKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbWFWVKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbWFWVKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:10:30 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:61084 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1752061AbWFWVK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:10:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Date: Fri, 23 Jun 2006 23:10:54 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, Frederik Deweerdt <deweerdt@free.fr>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org,
       stern@rowland.harvard.edu
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060623091016.GE4940@elf.ucw.cz> <20060623194100.GA3812@flint.arm.linux.org.uk>
In-Reply-To: <20060623194100.GA3812@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606232310.54564.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 23 June 2006 21:41, Russell King wrote:
> On Fri, Jun 23, 2006 at 11:10:21AM +0200, Pavel Machek wrote:
> > Serial console is currently broken by suspend, resume. _But_ I have a
> > patch I'd like you to try.... pretty please?
> 
> Did you bother trying my patch, which was done the Right(tm) way?
> There wasn't any feedback on it so I can only assume not.

Sorry for that, I just couldn't test it earlier.  Works for me. :-)

Thanks,
Rafael
