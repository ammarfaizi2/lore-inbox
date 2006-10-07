Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbWJGEGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWJGEGo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 00:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWJGEGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 00:06:44 -0400
Received: from xenotime.net ([66.160.160.81]:19178 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751618AbWJGEGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 00:06:43 -0400
Date: Fri, 6 Oct 2006 21:08:11 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Matt LaPlante <kernel1@cyberdogtech.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 19-rc1]  Fix typos in /Documentation : 'U-Z'
Message-Id: <20061006210811.8905c712.rdunlap@xenotime.net>
In-Reply-To: <20061006225211.1e88892d.kernel1@cyberdogtech.com>
References: <20061006095031.7dfcbe53.kernel1@cyberdogtech.com>
	<20061006190204.9ccacbeb.rdunlap@xenotime.net>
	<20061006225211.1e88892d.kernel1@cyberdogtech.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 22:52:11 -0400 Matt LaPlante wrote:

> Hi Randy,
>   Thanks for the feedback as always.  See below...
> 
> > > -iii.Ability to represent large i/os w/o unecessarily breaking them up (i.e
> > > +iii.Ability to represent large i/os w/o unnecessarily breaking them up (i.e
> > 
> > I'd prefer to see "I/Os"  "without"   "i.e.".
> 
> This style is throughout this text.  It can be changed, but would be easier to do in
> its own diff rather than changing the whole file here.  Left as-is.

Yes, agreed.


> > > -       triggers an interrupt on the SPU. The  value  writting  to  the  signal
> > > +       triggers an interrupt on the SPU.  The  value  writing  to  the  signal
> > 
> > I think that should be "written".
> > 
> > > -may result unpredictabe behavior.
> > > +may result unpredictable behavior.
> > 
> >    may result in unpredictable behavior.
> > 
> 
> Fixed and Fixed.  Updated version below.

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

---
~Randy
