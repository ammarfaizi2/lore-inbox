Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVEJVga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVEJVga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVEJVga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:36:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22740 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261818AbVEJVgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:36:23 -0400
Date: Tue, 10 May 2005 16:59:11 -0400
From: Bill Nottingham <notting@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050510205911.GA5144@nostromo.devel.redhat.com>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <20050510203156.GA14979@wonderland.linux.it> <20050510205239.GA3634@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510205239.GA3634@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH (gregkh@suse.de) said: 
> > > > Because it's impossible to predict how it will interact with other
> > > > install and alias commands.
> > > Then we will just have to find out :)
> > It should be clear that it will interact badly with another install
> > commands, with one of them being ignored. This is not acceptable.
> 
> Why?  Will they not all just be checked in order?

You can only have one install command per name.

Bill
