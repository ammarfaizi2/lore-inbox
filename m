Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbTFCMiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbTFCMiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:38:22 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:3750 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264981AbTFCMiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:38:21 -0400
Date: Tue, 3 Jun 2003 14:51:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030603125139.GA6670@wohnheim.fh-wedel.de>
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <1054519757.161606@palladium.transmeta.com> <20030603123256.GG1253@admingilde.org> <20030603124501.GB13838@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030603124501.GB13838@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 June 2003 13:45:01 +0100, Dave Jones wrote:
> On Tue, Jun 03, 2003 at 02:32:56PM +0200, Martin Waitz wrote:
> 
>  > well, but it is nice to be able to grep for the declaration of a
>  > function like
>  > 
>  > 	grep "^where_is_it" *.c
>  > 
>  > without showing all the uses of that function.
> 
> What's wrong with ctags for this?

- You have to set it up (hackers are lazy)
- You generate an extra file that some people might not want

imo it doesn't really matter much either way.  Whatever you prefer,
there are greater evils in the kernel, even in relatively important
parts.  So why bother with such minor and highly personal issues.

Jörn

-- 
Jörn Engel
mailto: joern@wohnheim.fh-wedel.de
http://wohnheim.fh-wedel.de/~joern
Phone: +49 179 6704074
