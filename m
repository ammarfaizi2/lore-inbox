Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbTCLUsQ>; Wed, 12 Mar 2003 15:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261944AbTCLUsQ>; Wed, 12 Mar 2003 15:48:16 -0500
Received: from jstevenson.plus.com ([212.159.71.212]:29850 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id <S261942AbTCLUsI>;
	Wed, 12 Mar 2003 15:48:08 -0500
Subject: Re: Linux BUG: Memory Leak
From: James Stevenson <james@stev.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: dave@cs.curtin.edu.au, "M. Soltysiak" <msoltysiak@hotmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030312192415.23935.qmail@linuxmail.org>
References: <20030312192415.23935.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Mar 2003 20:58:11 +0000
Message-Id: <1047502692.2064.3.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Wed, 2003-03-12 at 07:19, David Shirley wrote: 
> > iirc UT will only run with openGL under X last time i looked about 3 
> > months ago the only card that was fully supporting this was the nvidia 
> > Geforce series with closed source drivers. 
> >  
> > Tainted kernel :/ 
>  
> Besides tainted kernel, nVidia drivers are pretty good :-) 
> There are more GL-enabled cards standard with XFree86, like 
> Radeons and family. I have also had some success with Mach64 
> based video cards (although FPS rate is somewhat low). 

nvidia drivers

cat /dev/nvidia
causes a kernel opps



