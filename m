Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUB0Arr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbUB0Aqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:46:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:14043 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261505AbUB0AqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:46:20 -0500
Date: Thu, 26 Feb 2004 16:46:02 -0800
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       sensors@stimpy.netroedge.com
Subject: Re: 2.6.3-mm4
Message-ID: <20040227004602.GB15075@kroah.com>
References: <20040225185536.57b56716.akpm@osdl.org> <403E82D8.3030209@gmx.de> <20040225185536.57b56716.akpm@osdl.org> <20040227001115.GA2627@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403E82D8.3030209@gmx.de> <20040227001115.GA2627@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 01:11:15AM +0100, J.A. Magallon wrote:
> 
> As somebody also stated, there are problems with sensors:
> 

On Fri, Feb 27, 2004 at 12:35:52AM +0100, Prakash K. Cheemplavam wrote:
> Hi,
> 
> this release made my sensors broken. With mm3 it worked nicely.

Yup, we changed all of the sensors sysfs names :)

Hey, we did warn everyone here on lkml we were going to do this, and no
one complained...

Anyway, I think all you need to do is get the cvs tree of the lmsensors
package.  Sensors people, the needed changes are commited into the tree,
right?

thanks,

greg k-h
