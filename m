Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbTDIJ06 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTDIJ06 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:26:58 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4455 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262974AbTDIJ05 (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 05:26:57 -0400
Date: Wed, 9 Apr 2003 09:38:34 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: ioctls
Message-ID: <20030409093834.A15644@devserv.devel.redhat.com>
References: <mailman.1049841061.29063.linux-kernel2news@redhat.com> <200304090506.h39564208670@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304090506.h39564208670@devserv.devel.redhat.com>; from zaitcev@redhat.com on Wed, Apr 09, 2003 at 01:06:04AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 01:06:04AM -0400, Pete Zaitcev wrote:
> > ioctl definitions, and definitions of the argument structs
> > to files there?
> 
> There was a more comprehensive idea floated by Chrishtoff
> Hellwig last week. We ought to ask Arjan (or find someone
> else) to maintain glibc-kernelheaders as a community tarball
> at kernel.org somewhere. Please, don't look at me. OK, only
> if Arjan _REALLY_ refuses... Or perhaps you want to take
> it yourself? This is basically your idea, only halfway
> done: everything is copied already. Also, we do not need
> a buy-in from Linus (though I suspect he'd support it).

I have no problem with making the reduced headerset more generically
available (and then clean it up more etc etc); it needs for more people
than just me to care to make it worth it though.
