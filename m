Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTLDLy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 06:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTLDLy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 06:54:28 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:33686 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S261563AbTLDLy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 06:54:27 -0500
Date: Thu, 4 Dec 2003 03:54:14 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Fredrik Tolf <fredrik@dolda2000.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Why is hotplug a kernel helper?
Message-ID: <20031204115414.GH11065@ca-server1.us.oracle.com>
Mail-Followup-To: Fredrik Tolf <fredrik@dolda2000.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <16334.31260.278243.22272@pc7.dolda2000.com> <20031204011357.GA22506@kroah.com> <16334.38227.433336.514399@pc7.dolda2000.com> <20031204022911.GA23761@kroah.com> <16334.44085.362449.278626@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16334.44085.362449.278626@pc7.dolda2000.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 04:38:29AM +0100, Fredrik Tolf wrote:
> Admittedly, I'm still using the RH8 hotplug scripts, and I suspect
> improvements have been made since then. I was mainly looking for a way
> to auto-mount USB mass storage devices without having to reconfigure
> anything as root. I have all the info I need now, though.

	Hotplug (murasaki in my case) finds the devices just fine.  The
automounter (autofs for local filesystems) automounts them when I change
into the directory.  Also just fine.  In 2.4, no less.  2.6 as well.

Joel


-- 

"The nice thing about egotists is that they don't talk about other
 people."
         - Lucille S. Harper

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
