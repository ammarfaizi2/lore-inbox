Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbTEJONx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 10:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264244AbTEJONx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 10:13:53 -0400
Received: from smtp1.libero.it ([193.70.192.51]:60324 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S264189AbTEJONw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 10:13:52 -0400
Date: Sat, 10 May 2003 13:29:48 +0300
From: Daniele Pala <dandario@libero.it>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird errors for loading modules
Message-ID: <20030510102948.GA286@libero.it>
References: <A46BBDB345A7D5118EC90002A5072C780CCAFDA9@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780CCAFDA9@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 02:43:32PM -0700, Perez-Gonzalez, Inaky wrote:
> > From: Daniele Pala [mailto:dandario@libero.it]
> >
> > i recently comiled 2.5.69 kernel and all goes fine, 
> > except that i'm not able to load modules at
> > startup. The error
> > it gives is like: "modprobe: ERROR module xyz doesn't 
> >  exist in /proc/modules". The same error comes
> > out when i try to
> 
> Can you actually see the modules in /proc/modules if
> you cat it from the shell?
> 
> I?aky P?rez-Gonz?lez -- Not speaking for Intel -- all opinions are my own
> (and my fault)
> -

It's all ok now, i had the modprobe thing in the wrong location...i'm just too stupid
