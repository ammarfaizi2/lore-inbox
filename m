Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVEJVZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVEJVZm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVEJVZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:25:40 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:31756 "EHLO
	smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP id S261813AbVEJVWq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:22:46 -0400
Date: Tue, 10 May 2005 23:22:07 +0200
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: Greg KH <gregkh@suse.de>, "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050510232207.A7594@banaan.localdomain>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <20050510203156.GA14979@wonderland.linux.it> <20050510205239.GA3634@suse.de> <20050510210823.GB15541@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050510210823.GB15541@wonderland.linux.it>; from md@Linux.IT on Tue, May 10, 2005 at 11:08:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 11:08:23PM +0200, Marco d'Itri wrote:
> On May 10, Greg KH <gregkh@suse.de> wrote:
> 
> > > It's a feature which I know my users and other maintainers need
> > > (for duplicated drivers, OSS drivers, watchdog drivers, usb{mouse,kbd}
> > > and so on) so it's a prerequisite for the successful packaging of
> > > hotplug-ng.
> > Ok, then, care to make a patch to module-init-tools to provide this
> > functionality?
> Eventually yes if nobody else will beat me, but I cannot spend time on
> this currently.

This patch would also be very useful for my pet project, building
smarter initial ram images; I'll have a go at it.

Regards,
Erik
