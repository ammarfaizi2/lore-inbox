Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWE1PuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWE1PuF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 11:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWE1PuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 11:50:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:27865 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750781AbWE1PuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 11:50:03 -0400
Date: Sun, 28 May 2006 16:49:54 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Amy Griffis <amy.griffis@hp.com>, John McCutchan <john@johnmccutchan.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Robert Love <rlove@rlove.org>
Subject: Re: [PATCH] inotify kernel API
Message-ID: <20060528154954.GR27946@ftp.linux.org.uk>
References: <20060526021030.GA4936@zk3.dec.com> <1148659946.7612.7.camel@localhost.localdomain> <20060528024245.GA18625@zk3.dec.com> <1148805342.3074.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148805342.3074.12.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 10:35:42AM +0200, Arjan van de Ven wrote:
> On Sat, 2006-05-27 at 22:42 -0400, Amy Griffis wrote:
> > John McCutchan wrote:     [Fri May 26 2006, 12:12:26PM EDT]
> > > Having only glanced at your latest code, all of your changes and bug
> > > fixes look good. Thanks very much for putting the effort into auditing
> > > and testing inotify. 
> > 
> > Thanks, that's great to hear.
> 
> btw is the user of this in-kernel stuff also included?

It will be - that's used by pending kernel/audit* stuff.
