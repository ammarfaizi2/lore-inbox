Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbUACWd3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbUACWd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:33:29 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:9225 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264334AbUACWdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:33:25 -0500
Date: Sat, 3 Jan 2004 22:33:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Witukind <witukind@nsbm.kicks-ass.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev and devfs - The final word
Message-ID: <20040103223321.A11963@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Witukind <witukind@nsbm.kicks-ass.org>,
	linux-kernel@vger.kernel.org,
	linux-hotplug-devel@lists.sourceforge.net
References: <20031231002942.GB2875@kroah.com> <20040101011855.GA13628@hh.idb.hist.no> <20040103055938.GD5306@kroah.com> <20040103140140.3b848e9f.witukind@nsbm.kicks-ass.org> <20040103221604.GJ11061@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040103221604.GJ11061@kroah.com>; from greg@kroah.com on Sat, Jan 03, 2004 at 02:16:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 02:16:04PM -0800, Greg KH wrote:
> > If devfs works good on FreeBSD, it probably means that the current
> > devfs for Linux is badly designed, not that the idea of devfs is bad.
> 
> I have no idea how FreeBSD implemented devfs.
> 
> If you know how FreeBSD implemented devfs, and how it solves all of the
> problems that I detailed in my original posting, I would be interested.

The FreeBSD implementation is pretty similar to the devfs we have in 2.6
API- and implementation wise.  Just because it works somehow in most
situation doesn't mean it's right..

