Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbUBXTkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUBXTkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:40:14 -0500
Received: from storm.he.net ([64.71.150.66]:16256 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S262411AbUBXTkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:40:10 -0500
Date: Tue, 24 Feb 2004 11:40:10 -0800
From: Greg KH <greg@kroah.com>
To: Pat Gefre <pfg@sgi.com>
Cc: davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix hotplug
Message-ID: <20040224194010.GA639@kroah.com>
References: <20040223202313.GA22207@kroah.com> <Pine.SGI.3.96.1040224131106.43293E-100000@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.3.96.1040224131106.43293E-100000@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 01:12:14PM -0600, Pat Gefre wrote:
> We have a hotplug driver - not included in this update - this is just
> the kernel code.

How about posting both pieces so we can try to figure out how they are
intregrated.  Without that there is no way to judge this patch alone.

thanks,

greg k-h
