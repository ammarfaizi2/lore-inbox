Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVBWEGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVBWEGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 23:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVBWEGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 23:06:25 -0500
Received: from waste.org ([216.27.176.166]:42118 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261418AbVBWEGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 23:06:21 -0500
Date: Tue, 22 Feb 2005 20:06:16 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/6] Bind Mount Extensions 0.06
Message-ID: <20050223040616.GN3120@waste.org>
References: <20050222120955.GA3682@mail.13thfloor.at> <20050223032413.GB3163@waste.org> <20050222195102.49cf37da.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222195102.49cf37da.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 07:51:02PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> >  Please give each patch a unique, descriptive subject.
> 
> yup.
> 
> > Summarizing what
> >  each patch is doing in your 0/n so that reviewers can focus on the
> >  bits that are interesting is also helpful.
> 
> Actually, that's fairly irritating, because the 0/n contains useful info
> which someone has to go and massage and copy into 1/n.

Certainly, there should be nothing in the summary that isn't already
in the patch itself. What I'm suggesting is more a table of contents:

1/6 move foo to bar so that we can then remove baz
2/6 kill references to baz
...

-- 
Mathematics is the supreme nostalgia of our time.
