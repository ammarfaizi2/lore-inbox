Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbWBAPwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWBAPwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWBAPwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:52:05 -0500
Received: from opersys.com ([64.40.108.71]:28433 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1422647AbWBAPwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:52:02 -0500
Message-ID: <43E0DC7A.8020109@opersys.com>
Date: Wed, 01 Feb 2006 11:06:18 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Glauber de Oliveira Costa <glommer@gmail.com>
CC: Thomas Horsten <thomas@horsten.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk>	 <43DE57C4.5010707@opersys.com> <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com>
In-Reply-To: <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Glauber de Oliveira Costa wrote:
> I may be missing the point here, (In case you're more than welcome to
> correct me), but ... Why? Can't a software license restrict the usage
> of the software? In which ways do you think the sentence "Don't use in
> DRM'ed hardware" differs from sentences like  "Not allowed in country
> X",  "Don't use for commercial purposes",  and other alikes ? I think
> that saying in which hardware your software can or cannot run is a
> pretty valid license term (without messing with the question about it
> being the right thing to do here).

You're right, I didn't think it through properly ... I guess what I'm
trying to say is that the more restrictions a licensed work imposes
on its runtime environment, the less free it is. In my view of freedom,
a "free" license should indeed protect the software licensed under it,
but it should be as unintrussive with regards to runtime as possible
-- simply because the original author may not have anticipated all the
possible runtime scenarios. As a user, I should be free to decide what
hardware I'd like to see this software run on. In that regard, I think
GPLv2 strikes the right balance, while GPLv3 attempts to solve one
issue by introducing a lot of other problems.

... and bearing in mind that there are legitimate non-DRM embedded and
security applications where runtime software restrictions are required/
inherent ... think:
- software controlling consumer appliances such as cars, etc.
- masked-ROM software (non-flashable)
- access-control hardware
- high-end IT security
- etc.

FWIW, private discussions with RMS a few years back showed a clear
misunderstanding of how important embedded devices are. It really
seems to me that the FSF's newly found urgency for solving an
increasingly disturbing problem (DRM) is unfortunately not based on
internal familiarity with the embedded world. Contrary to the FSF's
long-standing experience of having its software used in workstations
and servers, it's only very recently that its software, and software
licensed under licenses it publishes, has been found in embedded
devices -- Though GCC & co have been used to cross-build for embedded
devices for a very long time, this is different from having the
actual software run on the gizmo.

This argument, in itself, doesn't diminish the value of the FSF's
position. They are indeed intent on defending software freedom and
in that I cannot condem them. However, I really think that those
championing this new wording should think through all the
possibilities. As a user, I clearly hate DRM and would indeed like
to see it disappear. As a developer, and an active participant in
the development of many kinds of embedded/customized systems, I
also see that the new wording imposes unrealistic limitations to
legitimate designs. IOW: right cause, wrong venue.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
