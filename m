Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292874AbSCJGHZ>; Sun, 10 Mar 2002 01:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292878AbSCJGHQ>; Sun, 10 Mar 2002 01:07:16 -0500
Received: from zero.tech9.net ([209.61.188.187]:57351 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292874AbSCJGHH>;
	Sun, 10 Mar 2002 01:07:07 -0500
Subject: Re: Kernel 2.5.6 Interactive performance
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: charles-heselton@cox.net, Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Dan Mann <mainlylinux@attbi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "J.A. Magallon" <jamagallon@able.es>
In-Reply-To: <20020310043854.GA311@matchmail.com>
In-Reply-To: <NFBBKFIFGLNJKLMMGGFPKEPDCFAA.charles-heselton@cox.net>
	<1015734229.858.4.camel@phantasy>  <20020310043854.GA311@matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 10 Mar 2002 01:05:55 -0500
Message-Id: <1015740391.858.44.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-03-09 at 23:38, Mike Fedyk wrote:

> On Sat, Mar 09, 2002 at 11:23:48PM -0500, Robert Love wrote:
> > The 2.5 tree also has most of these toys, and is a better place for this
> > development IMO.  Personally, I'd stay away from these all-in-one silly
> > patches that are floating around these days.  Your safest bet is just
> > stock 2.4.18 or whatever is latest, although the above addons are all at
> > varying levels of "stable" and "safe".
> > 
> 
> Then what do you call -aa and -ac? ;)
> 
> These "all-in-one" patches do make it harder to debug specific patches, but
> it does create a wider audience for many patches that wouldn't be used
> otherwise.

I don't put -aa nor -ac in the same category as what I refer to above. 
Alan and Andrea's trees both contain an intelligent combination of
useful patches, bug fixes, and code from Alan and Andrea themselves.

The plethora of all-in-one every-patch-under-the-sun patchsets don't
fall into the above category, in my opinion.  They just mix various new
feature patches.  They do offer one benefit: much wider exposure for
some potentially very useful patches.  I have found, however, that they
don't help the actual patch authors much since (a) they are mixed in
with many other patches and possibly even erroneously merged and (b) the
bug reports never make it upstream to the actual patch maintainers.

Maybe I'm just annoyed by the even greater signal-to-noise ratio on lkml
:-)

	Robert Love

