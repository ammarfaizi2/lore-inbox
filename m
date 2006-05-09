Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWEIT4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWEIT4T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWEIT4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:56:19 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45697 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750732AbWEIT4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:56:18 -0400
Date: Tue, 9 May 2006 12:58:43 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device hotplug driver.
Message-ID: <20060509195843.GO24291@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085200.826853000@sous-sol.org> <20060509194948.GB671@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509194948.GB671@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> And I sure hope you don't have a xen_proc.h file anywhere, we do not
> need any new non-process files going into /proc...

I'll be happy once we've got all the /proc abuse eliminated, sorry some
of this snuck through.

thanks,
-chris
