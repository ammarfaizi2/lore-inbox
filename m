Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267693AbUHJUH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267693AbUHJUH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267698AbUHJUH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:07:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44220 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267693AbUHJUHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:07:55 -0400
Date: Tue, 10 Aug 2004 16:07:42 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kurt Garloff <garloff@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
In-Reply-To: <20040810130009.P1924@build.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0408101607170.9332-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Chris Wright wrote:

> > I did some benchmarking (full results below), and I'm not seeing anything
> > significant on a P4 Xeon.
> 
> Is this new (i.e. you just did this)?  It's basically the same result we
> had from a few years ago.

Yes, did it today.


- James
-- 
James Morris
<jmorris@redhat.com>


