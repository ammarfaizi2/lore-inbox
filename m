Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWBBWtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWBBWtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWBBWtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:49:45 -0500
Received: from opersys.com ([64.40.108.71]:15629 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932434AbWBBWtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:49:45 -0500
Message-ID: <43E28FE2.8010701@opersys.com>
Date: Thu, 02 Feb 2006 18:04:02 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Glauber de Oliveira Costa <glommer@gmail.com>,
       Thomas Horsten <thomas@horsten.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk> <43DE57C4.5010707@opersys.com> <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com> <43E0DC7A.8020109@opersys.com> <20060202220206.GC2405@elf.ucw.cz>
In-Reply-To: <20060202220206.GC2405@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Machek wrote:
> What is wrong with changing software in my car? I'm allowed to cut my
> own brakes, why should I be disallowed in software in my car.

Lee aptly answered this one.

> That's fair; I don't think GPLv3 forbids ROMs, through.

If that's all it takes to not fall under the DRM requirements of the
GPLv3 then certainly no consumer electronics manufacturer that I know
of will hesitate to ship Linux (or any other piece of software I
should add) on masked ROMs should it ever convert to GPLv3. It's not
like they haven't been doing that for the past 30+ years. Any good
that will have done to any of those championing GPLv3 to help stop
DRM ...

Seriously, though, my earlier suggestion is even simpler. Just let
both signed and unsigned kernels run, just don't enable key user-
space-application-controlled hardware components if not signed and
do so in such a way requiring a power-up/hard-reset for another
pass at enable/disable. Perfectly permissible in the draft.

And I dare say that I hardly see how the FSF could try to cover this
one in any future draft since doing so would require having to place
restrictions on what independently-developed software/hardware
combinations are allowed in any system containing the covered
"work".

Like I said before: right cause, wrong venue.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
