Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279870AbRJ3E6K>; Mon, 29 Oct 2001 23:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279869AbRJ3E5w>; Mon, 29 Oct 2001 23:57:52 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:27010 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S279868AbRJ3E5a>; Mon, 29 Oct 2001 23:57:30 -0500
Message-ID: <3BDE3360.80731876@mcn.net>
Date: Mon, 29 Oct 2001 21:58:08 -0700
From: TimO <hairballmt@mcn.net>
Organization: Don't you mean Disorganization!?
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: "Kevin D. Wooten" <kwooten@home.com>, linux-kernel@vger.kernel.org
Subject: Re: Module Licensing?
In-Reply-To: <01102920463500.03524@newton.cevio.com> <3BDE27BE.3569FE22@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> "Kevin D. Wooten" wrote:
> >
> > After reading the posts about the MODULE_LICENSE macro, I am in disbelief. I
> > was under the impression that one could write a "closed-source" module and
> > distribute it in binary form, and be in compliance. Please tell me I am
> > wrong? We use Linux as a platform for some data acquisition, and we are
> > currently distributing ( in very limited quantity to people who would already
> > have signed an NDA ) modules that currently have no official license as yet.
> > We are researching which license to use, but according to these post's we
> > have almost no choice, Open Source or not at all!
> 
> No, you just can't use certain symbols if you're not GPL.  If your
> code already works, then you're fine, as previously existing symbols
> will not be thus restricted...  You can just make your MODULE_LICENSE == "mine-all-mine...including-all-my-bugs"

Ugghh!  Don't confuse/equate MODULE_LICENSE with EXPORT_SYMBOL_GPL_ONLY;
two different animals, two differnet goals.  See archives for more info.

> 
> Ben
> 
> >
> > -kw
> > -

-- 
===============
-- TimO
--------------------==============++==============--------------------
                             No Cool .sig
