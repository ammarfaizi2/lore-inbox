Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbTIFWIE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 18:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbTIFWIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 18:08:04 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:424 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261512AbTIFWIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 18:08:01 -0400
Date: Sun, 7 Sep 2003 00:08:00 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Fruhwirth Clemens <clemens-dated-1063628701.d72f@endorphin.org>
Cc: John Bradford <john@grabjohn.com>, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030906220800.GA18850@DUK2.13thfloor.at>
Mail-Followup-To: Fruhwirth Clemens <clemens-dated-1063628701.d72f@endorphin.org>,
	John Bradford <john@grabjohn.com>, joern@wohnheim.fh-wedel.de,
	linux-kernel@vger.kernel.org
References: <200309051225.h85CPOYr000323@81-2-122-30.bradfords.org.uk> <20030905122501.GA3250@leto2.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905122501.GA3250@leto2.endorphin.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 02:25:01PM +0200, Fruhwirth Clemens wrote:
> On Fri, Sep 05, 2003 at 01:25:24PM +0100, John Bradford wrote:
> > The point is, if somebody does find a bug they will want to
> > re-assemble with Gas after they've fixed it.
> 
> If you referring to my precompiled masm binaries, yes, if one wants to
> change the source, getting masm is not nice.
> 
> But if the source is writting in nasm, nasm (LGPL) can be installed
> easily.. 
> 
> However, the kernel folks seem to dislike to depend on an additional tool.
> Actually that's the answer to my original question. Now I just have to
> ponder if I favour the preferences of the kernel over the prefs of user space
> programs. There are lots of user space crypto implementations, which are
> potential candidates.. and for theses apps an additional dependency on nasm
> is no problem.

what it the problem with gas anyway? why not convert
the masterpiece to GNU Assembler? there even exists 
some script to aid in masm to gas conversion ...

http://www.delorie.com/djgpp/faq/converting/asm2s-sed.html

best,
Herbert

> Regards, Clemens


