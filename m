Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbTF1ALL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbTF1ALK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:11:10 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:32711 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264966AbTF1ALE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:11:04 -0400
Date: Fri, 27 Jun 2003 17:16:36 -0700
From: Greg KH <greg@kroah.com>
To: Valdis.Kletnieks@vt.edu
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       chris.ricker@genetics.utah.edu
Subject: Re: Hotplug/PPP oddness n 2.5.73-mm1 - scripts not running, bad event
Message-ID: <20030628001636.GA12229@kroah.com>
References: <200306252028.h5PKSSnd002877@turing-police.cc.vt.edu> <20030625145835.14206ec7.shemminger@osdl.org> <200306260307.h5Q37hCV003595@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306260307.h5Q37hCV003595@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 11:07:43PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > > case $ACTION in
> > > add|register)
> 
> Yeah, that was the fairly obvious fix... now who's job is it to fix it on the
> hotplug website, and when?

That would probably be me :)

I'll try to get to it on Monday and get out a new linux-hotplug script
package at the same time.

thanks,

greg k-h
