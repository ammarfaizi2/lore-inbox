Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265763AbSJSXYx>; Sat, 19 Oct 2002 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265765AbSJSXYw>; Sat, 19 Oct 2002 19:24:52 -0400
Received: from meel.hobby.nl ([212.72.224.15]:29449 "EHLO meel.hobby.nl")
	by vger.kernel.org with ESMTP id <S265763AbSJSXYv>;
	Sat, 19 Oct 2002 19:24:51 -0400
Date: Sun, 20 Oct 2002 01:20:57 +0200
From: Toon van der Pas <toon@vanvergehaald.nl>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
Message-ID: <20021020012057.B4900@vdpas.hobby.nl>
References: <3DB1DF34.3000600@quark.didntduck.org> <Pine.LNX.4.10.10210191550060.24031-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.10.10210191550060.24031-100000@master.linux-ide.org>; from andre@linux-ide.org on Sat, Oct 19, 2002 at 03:54:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 03:54:46PM -0700, Andre Hedrick wrote:
> On Sat, 19 Oct 2002, Brian Gerst wrote:
> > 
> > Attempting to read a "defective" disc should never, ever, cause a
> > kernel oops.  Whether it succeeds or not is irrelevant.
> 
> Please point out where in the original post, the referrence to
> "defective" media.  If this would have been the case, your point it
> valid.  If I missed something, thus am wrong, I will admit to being
> wrong.

AFAICS you missed something indeed:
Attempts to read copy-protected media should also never result in a kernel oops.

Regards,
Toon.
-- 
 /"\                             |
 \ /     ASCII RIBBON CAMPAIGN   |  "Who is this General Failure, and
  X        AGAINST HTML MAIL     |   what is he doing on my harddisk?"
 / \
