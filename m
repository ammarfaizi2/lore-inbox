Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUHIGTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUHIGTt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 02:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUHIGTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 02:19:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:30619 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266139AbUHIGTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 02:19:48 -0400
Date: Sun, 8 Aug 2004 23:15:30 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, Hollis Blanchard <hollisb@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cross-depmod?
Message-ID: <20040809061530.GA13528@kroah.com>
References: <1091742716.28466.27.camel@localhost> <20040806154211.GB7331@mars.ravnborg.org> <1091963200.27202.10.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091963200.27202.10.camel@bach>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 09:05:11AM +1000, Rusty Russell wrote:
> 
> I was always planning on doing this after we got rid of the modules.map
> files, but that never happened due to reluctance from other people to
> transition, and I didn't fight them.

The reluctance was just not-enough-time to update the hotplug scripts.

However, if you forced the issue and took away the files, making me fix
the hotplug scripts, that might just cause it to happen a lot sooner :)

thanks,

greg k-h
