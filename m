Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVCOR6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVCOR6v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVCOR4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:56:25 -0500
Received: from waste.org ([216.27.176.166]:7096 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261709AbVCORy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:54:58 -0500
Date: Tue, 15 Mar 2005 09:54:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: Greg KH <greg@kroah.com>
Cc: David Greaves <david@dgreaves.com>, Sam Ravnborg <sam@ravnborg.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Greg Norris <haphazard@kc.rr.com>,
       linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: Re: [BUG] Re: [PATCH] scripts/patch-kernel: use EXTRAVERSION
Message-ID: <20050315175436.GP32638@waste.org>
References: <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org> <20040814115548.A19527@infradead.org> <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org> <411E0A37.5040507@anomalistic.org> <20040814205707.GA11936@yggdrasil.localdomain> <20040818135751.197ce3c9.rddunlap@osdl.org> <20040822204002.GB8639@mars.ravnborg.org> <42370A3A.6020206@dgreaves.com> <20050315162545.GB24796@kroah.com> <20050315174424.GB26060@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315174424.GB26060@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 09:44:24AM -0800, Greg KH wrote:
> On Tue, Mar 15, 2005 at 08:25:46AM -0800, Greg KH wrote:
> > On Tue, Mar 15, 2005 at 04:15:54PM +0000, David Greaves wrote:
> > > Old thread (!) but this is the last time I could find patch-kernel updated.
> > 
> > Why not just use ketchup instead?
> 
> Actually, why not just replace patch-kernel with ketchup?
> 
> Matt, is that ok with you?

Yes. There are a handful of cleanups that I should do first though.

-- 
Mathematics is the supreme nostalgia of our time.
