Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319128AbSIJOGD>; Tue, 10 Sep 2002 10:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319131AbSIJOGD>; Tue, 10 Sep 2002 10:06:03 -0400
Received: from angband.namesys.com ([212.16.7.85]:16768 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S319128AbSIJOGC>; Tue, 10 Sep 2002 10:06:02 -0400
Date: Tue, 10 Sep 2002 18:10:45 +0400
From: Oleg Drokin <green@namesys.com>
To: Dave Jones <davej@suse.de>, Hans Reiser <reiser@namesys.com>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k at a time)
Message-ID: <20020910181045.A1095@namesys.com>
References: <3D7DF05E.7030903@namesys.com> <20020910160659.A15158@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020910160659.A15158@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Sep 10, 2002 at 04:07:00PM +0200, Dave Jones wrote:
>  > It passes all of our testing, but it is the kind of code that is more 
>  > likely than most to have elusive lurking bugs.  It cannot be tested in 
>  > 2.5 first because 2.5 is too broken at this particular moment.
> What in particular holds you back from testing this in 2.5 ?

I cannot boot into 2.5.34, that's it. ;)

> This seems quite dubious for inclusion first in what it supposed
> to be the stable series.

I believe that code itself is pretty stable now ;)
Also it got some testing outside of NAMESYS already.

Bye,
    Oleg
