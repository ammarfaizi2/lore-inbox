Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265767AbSLQWqk>; Tue, 17 Dec 2002 17:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbSLQWqj>; Tue, 17 Dec 2002 17:46:39 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5504 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265767AbSLQWqj>;
	Tue, 17 Dec 2002 17:46:39 -0500
Date: Tue, 17 Dec 2002 14:54:28 -0800
From: Bob Miller <rem@osdl.org>
To: eric lin <fsshl@centurytel.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52 compile error
Message-ID: <20021217225428.GC1069@doc.pdx.osdl.net>
References: <3E058049@zathras> <20021217211618.GB1069@doc.pdx.osdl.net> <3E001825.7080709@centurytel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E001825.7080709@centurytel.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 11:39:33PM -0700, eric lin wrote:
> Bob Miller wrote:
> >On Tue, Dec 17, 2002 at 03:57:01PM -0500, rtilley wrote:
> >
> >>Using RH's default *i686.config to build a vanilla 2.5.52 kernel. It 
> >>keeps returning this error on 2 totally different x86 PCs:
> >>
> >>

Stuff deleted.

> >>
> >>
> >>Where is the fix for this?
> >>
> >
> >At your finger tips ;-).  Turn on CONFIG_INPUT via "Input device support"
> >off the main page.
> I did not know what is that mean (off the man page)?
> >
> Is that at menuconfig
> or
> should modify any source code?
> 
Yes it is at off the first page of "make menuconfig".

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
