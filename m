Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUANVOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbUANVOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:14:33 -0500
Received: from mail.kroah.org ([65.200.24.183]:34484 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263850AbUANVOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:14:32 -0500
Date: Wed, 14 Jan 2004 13:10:43 -0800
From: Greg KH <greg@kroah.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Nuno Silva <nuno.silva@vgertech.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 013 release
Message-ID: <20040114211043.GA6650@kroah.com>
References: <20040113235213.GA7659@kroah.com> <4004D084.1050106@vgertech.com> <20040114171527.GB5472@kroah.com> <40058086.5000106@nortelnetworks.com> <yqujn08q46ct.fsf@chaapala-lnx2.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yqujn08q46ct.fsf@chaapala-lnx2.cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 02:34:26PM -0600, Clay Haapala wrote:
> On Wed, 14 Jan 2004, Chris Friesen spake thusly:
> > 
> > Maybe for ones with a matching rule, you could print something like:
> > 
> > 
> Is the act of printing/syslogging a rule in an of itself? 

No, as currently the only way stuff ends up in the syslog is if
DEBUG=true is used on the build line.

But it's sounding like we might want to change that... :)

thanks,

greg k-h
