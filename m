Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270486AbTGXFGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 01:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270490AbTGXFGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 01:06:24 -0400
Received: from CPE-65-29-18-15.mn.rr.com ([65.29.18.15]:29826 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S270486AbTGXFGX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 01:06:23 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Shawn <core@enodev.com>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Hans Reiser <reiser@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <3F1F66F0.1050406@tupshin.com>
References: <3F1EF7DB.2010805@namesys.com>  <3F1F6005.4060307@tupshin.com>
	 <1059021113.7911.13.camel@localhost>  <3F1F66F0.1050406@tupshin.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059024090.9728.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 24 Jul 2003 00:21:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the 2.5.74 is the last one of any respectable size. I'm
thinking someone forgot a diff switch (N?) over at namesys...

Hans? Time to long-distance spank someone?

On Wed, 2003-07-23 at 23:56, Tupshin Harper wrote:
> Shawn wrote:
> 
> >This is pretty f'ed, but it's on ftp://ftp.namesys.com/pub/tmp
> >
> Thanks, but I tried applying the
> 2.6.0-test1-reiser4-2.6.0-test1.diff from that location with a lack of 
> success.
> 
> It applied cleanly, but it doesn't add a fs/reiser4 directory and 
> asociated contents. Is there an additional patch, or is this one broken?
> 
> -Tupshin
> 
