Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277665AbRJIAX4>; Mon, 8 Oct 2001 20:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277662AbRJIAXh>; Mon, 8 Oct 2001 20:23:37 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:29947 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S277661AbRJIAXS>;
	Mon, 8 Oct 2001 20:23:18 -0400
Date: Tue, 9 Oct 2001 02:23:41 +0200
From: David Weinehall <tao@acc.umu.se>
To: Seiichi Nakashima <nakasei@kamakura.mdis.co.jp>
Cc: linux-kernel@vger.kernel.org, nakasei@fa.mdis.co.jp
Subject: Re: linux-2.0.40-pre2 patch error
Message-ID: <20011009022341.Z7800@khan.acc.umu.se>
In-Reply-To: <20010923145654.F26627@khan.acc.umu.se> <200110090013.AA00291@MJ136.kamakura.mdis.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200110090013.AA00291@MJ136.kamakura.mdis.co.jp>; from nakasei@kamakura.mdis.co.jp on Tue, Oct 09, 2001 at 09:13:38AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 09:13:38AM +0900, Seiichi Nakashima wrote:
> Dear. David Weinehall
> 
> I am Seiichi Nakashima.
> 
> >
> >Thanks a lot. I've fixed those two warnings and the error in my tree;
> >expect a pre2 shortly.

Ok, that's of course because of stupid me applying a patch to
the wrong kernel-tree. Sigh...

Will be fixed in v2.0.40-pre3. This code isn't ever executed by the
kernel afaict, but non-the-less it's good to be correct.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
