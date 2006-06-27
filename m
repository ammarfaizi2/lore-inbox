Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbWF0PwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWF0PwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbWF0PwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:52:22 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:52183 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1161125AbWF0PwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:52:21 -0400
Message-ID: <351423538.03814@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 27 Jun 2006 23:52:27 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm3: no help text for READAHEAD_ALLOW_OVERHEADS
Message-ID: <20060627155227.GA6014@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060627015211.ce480da6.akpm@osdl.org> <20060627091429.GK23314@stusta.de> <20060627134337.GA6117@mail.ustc.edu.cn> <20060627144019.GA13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627144019.GA13915@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 04:40:19PM +0200, Adrian Bunk wrote:
> On Tue, Jun 27, 2006 at 09:43:37PM +0800, Wu Fengguang wrote:
> > On Tue, Jun 27, 2006 at 11:14:29AM +0200, Adrian Bunk wrote:
> > > On Tue, Jun 27, 2006 at 01:52:11AM -0700, Andrew Morton wrote:
> > > >...
> > > > Changes since 2.6.17-mm2:
> > > > +readahead-kconfig-option-readahead_allow_overheads.patch
> > > >...
> > > >  readahead updates
> > > >...
> > > 
> > > The READAHEAD_ALLOW_OVERHEADS option lacks a help text.
> > 
> > Oh, it just acts as a submenu and a reminder ;)
> > 
> > > Additionally, the "default n" is pointless and should be removed.
> > 
> > I expect the _extra_ features are useless for normal users.
> > Your reasoning or feeling?
> >...
> 
> That's not my point, my point is that if you remove the "default n" 
> line, nothing changes. The default is still "n", but it's better 
> readable.

Sorry, I didn't know that. Thanks.

Wu
