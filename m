Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264368AbUEMX3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbUEMX3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUEMX3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:29:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:63919 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264368AbUEMX3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:29:20 -0400
Date: Thu, 13 May 2004 16:28:34 -0700
From: Greg KH <greg@kroah.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Todd Poynor <tpoynor@mvista.com>, mochel@digitalimplant.org,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Hotplug events for system suspend/resume
Message-ID: <20040513232834.GA21322@kroah.com>
References: <20040511010015.GA21831@dhcp193.mvista.com> <20040511230001.GA26569@kroah.com> <40A17251.2000500@mvista.com> <20040512150818.GE10924@kroah.com> <40A3FAB4.7090401@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A3FAB4.7090401@am.sony.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 03:46:12PM -0700, Tim Bird wrote:
> 
> Sony has experience with notifiers using /proc in a 2.4 kernel, so
> I don't know if we can directly comment on the details of a hotplug-based
> notification scheme.  But I can say that kernel-to-user notifications
> is an important feature for us.

I don't see anything in your use cases that will not work with the
current interfaces in 2.6.  If not, please let us know.

> I hope this is helpful.

It is, I hope the embedded developers will start to interact with the
kernel community more so than they currently are.

thanks,

greg k-h
