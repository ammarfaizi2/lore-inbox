Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273442AbRIWM5T>; Sun, 23 Sep 2001 08:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273476AbRIWM5C>; Sun, 23 Sep 2001 08:57:02 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:5886 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S273440AbRIWM4k>;
	Sun, 23 Sep 2001 08:56:40 -0400
Date: Sun, 23 Sep 2001 14:56:54 +0200
From: David Weinehall <tao@acc.umu.se>
To: Seiichi Nakashima <nakasei@fa.mdis.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.0.40-pre1 compile error
Message-ID: <20010923145654.F26627@khan.acc.umu.se>
In-Reply-To: <200109230202.AA00028@prism.fa.mdis.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200109230202.AA00028@prism.fa.mdis.co.jp>; from nakasei@fa.mdis.co.jp on Sun, Sep 23, 2001 at 11:02:39AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 11:02:39AM +0900, Seiichi Nakashima wrote:
> Dear. David Weinehall
> 
> I am Seiichi Nakashima.
> 
> Today, I found a new linux-2.0.40-pre1 kernel patch in kernel.org
> tao's directory.  I download patch and applied to linux-2.0.39 and
> compile kernel, but compile error occured at traps.c compile step.

Thanks a lot. I've fixed those two warnings and the error in my tree;
expect a pre2 shortly.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
