Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270422AbRHHJCP>; Wed, 8 Aug 2001 05:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270426AbRHHJCH>; Wed, 8 Aug 2001 05:02:07 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:11904 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S270422AbRHHJB5>; Wed, 8 Aug 2001 05:01:57 -0400
From: David Lang <david.lang@digitalinsight.com>
To: john slee <indigoid@higherplane.net>
Cc: Noel Koethe <noel@koethe.net>, linux-kernel@vger.kernel.org
Date: Wed, 8 Aug 2001 00:44:53 -0700 (PDT)
Subject: Re: 2.4.x IP aliase max eth0:16 (16 aliases), where to change?
In-Reply-To: <20010808172359.B2770@higherplane.net>
Message-ID: <Pine.LNX.4.33.0108080044210.4675-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

at least with previous versions it took a kernel source tweak to get more
then 255 aliases.

David Lang

On Wed, 8 Aug 2001, john slee wrote:

> Date: Wed, 8 Aug 2001 17:23:59 +1000
> From: john slee <indigoid@higherplane.net>
> To: Noel Koethe <noel@koethe.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.x IP aliase max eth0:16 (16 aliases), where to change?
>
> On Tue, Aug 07, 2001 at 10:41:27PM +0200, Noel Koethe wrote:
> > The maximum aliases I can configure with a 2.4.x kernel is 16, right?
>
> $ /sbin/ifconfig -a | grep -c eth0:
> 55
>
> and i'm an anti-twiddle person.  i've certainly never seen any limit on
> this here.  i've heard of people with hundreds or even thousands of
> aliases...
>
> j.
>
> --
> "Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
