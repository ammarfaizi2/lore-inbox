Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290470AbSAYBN6>; Thu, 24 Jan 2002 20:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290472AbSAYBNs>; Thu, 24 Jan 2002 20:13:48 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:52751 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S290470AbSAYBNf>; Thu, 24 Jan 2002 20:13:35 -0500
Date: Fri, 25 Jan 2002 01:16:40 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020125011640.GA22696@compsoc.man.ac.uk>
In-Reply-To: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org> <200201242246.g0OMkML06890@home.ashavan.org.> <1011913193.810.26.camel@phantasy> <200201242308.g0ON8HL06970@home.ashavan.org.>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201242308.g0ON8HL06970@home.ashavan.org.>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 05:09:45PM -0600, Timothy Covell wrote:

> My mistake, I was looking at the ouput of my "char x;" example,
> which IMHO is even worse.
> 
> covell@xxxxxx ~>gcc -Wall foo.c
> foo.c: In function `main':
> foo.c:17: warning: implicit declaration of function `exit'

and it's still your mistake. Try -O2 as well.

john

-- 
"ALL television is children's television."
	- Richard Adler 
