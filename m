Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261191AbRELD7o>; Fri, 11 May 2001 23:59:44 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261155AbRELD5m>; Fri, 11 May 2001 23:57:42 -0400
Received: from zeus.kernel.org ([209.10.41.242]:49800 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261161AbRELD5a>;
	Fri, 11 May 2001 23:57:30 -0400
Date: Fri, 11 May 2001 23:20:31 -0300
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
Message-ID: <20010511232031.A2314@bacchus.dhis.org>
In-Reply-To: <p05100303b70eadd613b0@[207.213.214.37]> <80BTbI6mw-B@khms.westfalen.de> <p0510030ab716bdcf5556@[207.213.214.37]> <20010511133242.B3224@bacchus.dhis.org> <p0510030db7221c090810@[10.128.7.49]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p0510030db7221c090810@[10.128.7.49]>; from jlundell@pobox.com on Fri, May 11, 2001 at 03:49:05PM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 03:49:05PM -0700, Jonathan Lundell wrote:

> >>  >If you want to support wrapping with plain text, investigate
> >>  >format=flowed.
> >>
> >>  Yes, I did that.
> >>
> >  > I'm curious, though: I haven't found the mail standards that forbid
> >>  receivers to wrap long lines. Certainly many mail clients do it.
> >>  What's the relevant RFC?
> >
> >RFC 2822, 2.1.1.
> 
> Thanks. It's not quite a standard yet, but it's true, it does limit 
> lines to 998 characters. Sort of a strange limit, but there you 
> are....

It's 998 plus a CR/LF sequence which is 1000 bytes, not exactly an odd
number.  And it's the official successor of RFC 822 which was an official
STD.

  Ralf
