Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUBINkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUBINkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:40:10 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:50401 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id S265200AbUBINkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:40:07 -0500
Date: Mon, 9 Feb 2004 13:40:05 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040209134005.GA15739@axis.demon.co.uk>
References: <c07c67$vrs$1@terminus.zytor.com> <20040209092915.GA11305@axis.demon.co.uk> <20040209124739.GC1738@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040209124739.GC1738@mail.shareable.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 12:47:39PM +0000, Jamie Lokier wrote:
> Nick Craig-Wood wrote:
> > On Mon, Feb 09, 2004 at 07:17:27AM +0000, H. Peter Anvin wrote:
> > > Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?
> > 
> > I use them quite a lot for testing serial port stuff in shell scripts,
> > eg connect one process which expects a serial port to /dev/ttys0 and
> > another to /dev/ptys0.  I expect there is a sane way of doing this new
> > style pty's - I just don't know it!
> 
> Look up "Pseudo-Terminals" in the libc info pages.
> http://www.delorie.com/gnu/docs/glibc/libc_376.html

Interesting but doesn't help my shell script!

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
