Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbTBFVGh>; Thu, 6 Feb 2003 16:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbTBFVGh>; Thu, 6 Feb 2003 16:06:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:35514 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267395AbTBFVGf>;
	Thu, 6 Feb 2003 16:06:35 -0500
Subject: Re: [PATCH 2.5] fix megaraid driver compile error
From: Mark Haverkamp <markh@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1044565217.14310.253.camel@spc9.esa.lanl.gov>
References: <Pine.LNX.4.44.0302061202430.3545-100000@home.transmeta.com>
	 <1044565217.14310.253.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Organization: 
Message-Id: <1044566213.26726.3.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 06 Feb 2003 13:16:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 13:00, Steven Cole wrote:
> On Thu, 2003-02-06 at 13:04, Linus Torvalds wrote:
> > 
> > On 6 Feb 2003, Mark Haverkamp wrote:
> > >
> > > This moves access of the host element to device since host has been
> > > removed from struct scsi_cmnd.
> > 
> > This is whitespace-damaged.
> > 
> > Please fix broken mailers. I generally don't bother to fix up whitespace
> > damage from people who can't bother to have a good mailer. It's just not 
> > worth it - if I try to fix it up (even if it is often trivial), it just 
> > means that people will continue to send crap patches to me.
> > 
> > 		Linus
> 
> In this case the issue is not a broken mailer, but rather the improper
> use of a good one.  Mark is using Evolution and so am I.  It appears
> that he did a cut and paste from an xterm (or something similar) which
> converted the tabs to spaces.

You are correct.   I wasn't thinking and did a cut/paste.

-- 
Mark Haverkamp <markh@osdl.org>

