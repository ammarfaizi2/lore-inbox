Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272071AbTHBC4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 22:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272139AbTHBC4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 22:56:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:8097 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272071AbTHBC4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 22:56:38 -0400
Date: Fri, 1 Aug 2003 19:56:21 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?Ram=F3n?= Rey Vicente???? <ramon.rey@hispalinux.es>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.0-test2-mm2] Badness in device_release at drivers/base/core.c:84
Message-ID: <20030802025621.GA2651@kroah.com>
References: <1059785617.1873.5.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1059785617.1873.5.camel@debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 02:53:38AM +0200, Ramón Rey Vicente???? wrote:
> Hi.
> 
> I obtain the included log messages on reboots
> 
> Badness in device_release at drivers/base/core.c:84
> Badness in kobject_cleanup at lib/kobject.c:402

Please search the archives before posting this kind of stuff.

These problems have been fixed and are in Linus's tree.

thanks,

greg k-h
