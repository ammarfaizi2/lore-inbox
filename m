Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263706AbTIHW1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTIHW1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:27:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:7623 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262942AbTIHW1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:27:30 -0400
Subject: Re: Plans for better performance metrics in upcoming kernels?
From: Craig Thomas <craiger@osdl.org>
To: scott_list@mischko.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200309080754.55700.scott_list@mischko.com>
References: <200309051641.44228.scott_list@mischko.com>
	 <200309080754.55700.scott_list@mischko.com>
Content-Type: text/plain
Organization: 
Message-Id: <1063060034.16303.23.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Sep 2003 15:27:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a project to maintain and improve systat here at OSDL.  We're 
looking for others to help in this area, if your're interested. 

On Mon, 2003-09-08 at 07:54, Scott Chapman wrote:
> Hi all,
> 
> I received one reply to this email.  I take it there is nobody really heading 
> up the implementation of improved/missing performance metrics in the kernel?
> 
> Is this on anyone's radar?
> 
> What is Linus' take on more/better metrics?  
> Is he likely to roll them in if they are implemented?
> 
> Is there any plan to implement any existing patches? 
> 
> If I can get developer time applied to this project, I don't want to re-invent 
> the existing pieces.  Who do I coordinate with?
> 
> Cordially,
> Scott
> 
> On Friday 05 September 2003 16:41, Scott Chapman wrote:
> > Hi,
> > I'm wondering what the plans are for more accurate and more useful
> > performance metrics in upcoming kernels.
> >
> > CPU Utilization by process is apparently a known-inaccuracy.
> >
> > There are no disk I/O metrics per process.
> >
> > CPU Queue Length doesn't appear to be available?
> >
> > Etc.
> >
> > Linux clearly falls behind the competition in this area. It makes it rather
> > tough to do system performance analysis on a Linux box!  :-)
> >
> > Is there a plan to deal with these issues?  ETA's?
> >
> > Cordially,
> > Scott
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Craig Thomas
craiger@osdl.org

