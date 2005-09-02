Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbVIBC6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVIBC6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 22:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbVIBC6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 22:58:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53472 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030415AbVIBC6P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 22:58:15 -0400
Date: Fri, 2 Sep 2005 03:57:46 +0100
From: viro@ZenIV.linux.org.uk
To: Andrew Morton <akpm@osdl.org>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 0/10] m68k/thread_info merge
Message-ID: <20050902025746.GE26264@ZenIV.linux.org.uk>
References: <Pine.LNX.4.61.0509012211010.8099@scrub.home> <20050901171621.33d41b3c.akpm@osdl.org> <20050901171738.49d8893d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901171738.49d8893d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 05:17:38PM -0700, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Can I assume that the five m68k patches can be split apart from the five
> > patches which dink with task_struct?  ie: if the task_struct patches go in
> > later, does anything bad happen?
> 
> eh, forget I asked that.  They're interdependent.

... but do not have to be.
