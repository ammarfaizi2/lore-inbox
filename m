Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUGIBT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUGIBT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 21:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUGIBT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 21:19:26 -0400
Received: from dsl-217-155-222-126.zen.co.uk ([217.155.222.126]:13536 "EHLO
	mail.recruit2recruit.net") by vger.kernel.org with ESMTP
	id S262114AbUGIBTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 21:19:24 -0400
Message-ID: <33035.82.69.73.113.1089335947.squirrel@82.69.73.113>
In-Reply-To: <40EDE956.80705@kolivas.org>
References: <40EC13C5.2000101@kolivas.org>	<40EC1930.7010805@comcast.net>	<40EC1B0A.8090802@kolivas.org>	<20040707213822.2682790b.akpm@osdl.org>	<cone.1089268800.781084.4554.502@pc.kolivas.org>	<20040708001027.7fed0bc4.akpm@osdl.org>	<cone.1089273505.418287.4554.502@pc.kolivas.org>	<20040708010842.2064a706.akpm@osdl.org>	<40ED7534.4010409@kolivas.org>
    <20040708094406.2b0293ea.akpm@osdl.org> <40EDE956.80705@kolivas.org>
Date: Fri, 9 Jul 2004 02:19:07 +0100 (BST)
Subject: Re: [ck] Re: [PATCH] Autotune swappiness
From: "Kerin Millar" <kerin@recruit2recruit.net>
To: "Con Kolivas" <kernel@kolivas.org>
Cc: "Andrew Morton" <akpm@osdl.org>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> I need someone with more varied hardware to test it for me. I can
> recreate equivalent results on my current machine which has similar
> hardware, but I think results showing improvement on different machines
>   and different loads is what you're looking for... and since I'm
> currently quite low on hardware I can only offer results from this one
> (and my wife is hating it being offline o_0)
>
> Anyone willing to offer to do some tests?

Yes - I would. If you can define a digestible framework for testing then I
would be more than happy to work through it - digestible for mere mortals,
that is ;). I have three machines on which I currently have the
opportunity to conduct such tests:

* PIII (733MHz), 384Mb RAM, VIA Apollo MVP3 chipset
* Compaq Presario, P4 2GHz, 256Mb RAM, Brookdale-G chipset
* Compaq Proliant ML370 G3 server, P4 Xeon 3.06GHz (HT), 1Gb RAM

All machines have similar software characteristics - identical toolchain,
same versions of core GNU tools and so forth. By all means, let me know if
there is anything I can do to help.

Regards,

--Kerin Francis Millar

