Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSBOBAr>; Thu, 14 Feb 2002 20:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285589AbSBOBAj>; Thu, 14 Feb 2002 20:00:39 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:34534 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S285720AbSBOBA2>; Thu, 14 Feb 2002 20:00:28 -0500
Date: Thu, 14 Feb 2002 19:00:03 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Robert Love <rml@tech9.net>
Cc: john slee <indigoid@higherplane.net>, J Sloan <joe@tmsusa.com>,
        linux-kernel@vger.kernel.org
Subject: Re: tux officially in kernel?
Message-ID: <20020214190003.B1518@asooo.flowerfire.com>
In-Reply-To: <Pine.LNX.4.30.0202111313100.28040-100000@mustard.heime.net> <3C67F327.8010404@tmsusa.com> <20020213135841.GB4826@higherplane.net> <3C6C4942.4050305@lexus.com> <1013730883.807.251.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1013730883.807.251.camel@phantasy>; from rml@tech9.net on Thu, Feb 14, 2002 at 06:54:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem with X15 is that it's unavailable.  I've tried for months
and months to get someone at that company to respond or get a copy to
try.  Also, is it GPL?  Free?

For me, X15 are three alphanumeric characters.

I'd love to try it, though.

As for TUX, I would certainly prefer user-space if it was indeed as fast
in all cases.  But I don't think X15 is really a factor in TUX's
inclusion.  I'd say replacing khttpd with TUX2 is a no-brainer unless
X15's performance has been proven and it's GPL.  And while khttpd is an
interesting example, it really rocks at small image serving.  I've had
it in production since 2.4.0-test1.
-- 
Ken.
brownfld@irridia.com

On Thu, Feb 14, 2002 at 06:54:41PM -0500, Robert Love wrote:
| On Thu, 2002-02-14 at 18:33, J Sloan wrote:
| 
| > So, just out of curioisity, why is khttpd in
| > the kernel? If there were any web server
| > in the mainline kernel I'd think it'd be tux -
| 
| Personally khttpd should be ripped from the kernel.  It is a nice, uh,
| example.  Or something.
| 
| TUX touches enough code that it isn't a clear decision to merge,
| although it is certainly worth it.  I, however, think we are rapidly
| approaching the point, if not there already, that with a zero-copy
| network driver userspace can perform as good as TUX with none of the
| downsides.  That was part of Ingo's goal and a lot of the benefits -
| sendfile etc - are a result of TUX.
| 
| Anyhow, if I recall correctly, X15 performed better than TUX.
| 
| 	Robert Love
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
