Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274942AbTHFJGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 05:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274948AbTHFJGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 05:06:19 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:15492 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S274942AbTHFJGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 05:06:18 -0400
Date: Wed, 6 Aug 2003 11:05:26 +0200
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] 2.4.22-pre10-ac1 after resume from suspend usb not aviable
Message-ID: <20030806090525.GA10564@puettmann.net>
References: <20030805143254.GA5844@puettmann.net> <20030806055732.GC6966@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806055732.GC6966@kroah.com>
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19kKEY-0002kh-00*qGq.BZ2g0JA* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 10:57:32PM -0700, Greg KH wrote:
> On Tue, Aug 05, 2003 at 04:32:54PM +0200, Ruben Puettmann wrote:
> > 
> > Suspend works if radeonfb is not loaded. But after resume from suspend
> > all USB devices are not aviable. If I try to start the hotplug manager
> > new I got this Errors: 
> 
> Try unloading all usb drivers before suspending, that should work
> better.
> 

That can not be the solution. It's a not nice workaround.

            ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
