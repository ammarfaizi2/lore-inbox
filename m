Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVBXVEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVBXVEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVBXVEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:04:51 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:61405 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262480AbVBXVEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:04:43 -0500
Date: Thu, 24 Feb 2005 22:04:42 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/6] Bind Mount Extensions 0.06
Message-ID: <20050224210442.GB4981@mail.13thfloor.at>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
References: <20050222120955.GA3682@mail.13thfloor.at> <20050223032413.GB3163@waste.org> <20050222195102.49cf37da.akpm@osdl.org> <20050223040616.GN3120@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223040616.GN3120@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 08:06:16PM -0800, Matt Mackall wrote:
> On Tue, Feb 22, 2005 at 07:51:02PM -0800, Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:
> > >
> > >  Please give each patch a unique, descriptive subject.
> > 
> > yup.
> > 
> > > Summarizing what
> > >  each patch is doing in your 0/n so that reviewers can focus on the
> > >  bits that are interesting is also helpful.
> > 
> > Actually, that's fairly irritating, because the 0/n contains useful info
> > which someone has to go and massage and copy into 1/n.
> 
> Certainly, there should be nothing in the summary that isn't already
> in the patch itself. What I'm suggesting is more a table of contents:
> 
> 1/6 move foo to bar so that we can then remove baz
> 2/6 kill references to baz
> ...

well, okay, that is in the comment at the start
of the patch, (because it sometimes is rather lengthy)
but I'll try to add something like a short version to
the subject in the future ...

thanks for the input!
Herbert

> 
> -- 
> Mathematics is the supreme nostalgia of our time.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
