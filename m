Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWEWKcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWEWKcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 06:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWEWKcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 06:32:07 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:11932 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751316AbWEWKcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 06:32:06 -0400
Message-ID: <018401c67e54$1043cfb0$1800a8c0@dcccs>
From: =?ISO-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: <kernel@kolivas.org>, <cw@f00f.org>, <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <200605222117.27433.kernel@kolivas.org> <031001c67db1$a8c4a1e0$1800a8c0@dcccs> <200605230112.45564.kernel@kolivas.org> <047401c67de3$a05a52c0$1800a8c0@dcccs> <4472D327.3060808@yahoo.com.au> <013601c67e51$eef03c10$1800a8c0@dcccs> <4472E2E0.4000201@yahoo.com.au>
Subject: Re: swapper: page allocation failure. - random reboot problem
Date: Tue, 23 May 2006 12:31:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Nick Piggin" <nickpiggin@yahoo.com.au>
To: "Haar János" <djani22@netcenter.hu>
Cc: <kernel@kolivas.org>; <cw@f00f.org>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, May 23, 2006 12:24 PM
Subject: Re: swapper: page allocation failure. - random reboot problem


> Haar János wrote:
>
> > Sorry,  i have allready did these things.
> >
> > The motherboard + CPU + RAM successed the overnight memtest, but anyway
i
> > have replaced this group with another pre-tested ones, but no change!
> > (Additionally, i replaced the NIC [e1000 to e1000, and e1000 to
realtek],
> > the sata cards [promise to promise], the sata and ide cables, mb, cpu,
ram,
> > ps, and the power cable too.
> > Only the 12hdd is the same, but smart reports no errors at all!)
> > The power supply is the 3rd. and the problem is the same.
>
> But is the power supply rated enough to support all the drives?
> I have seen random reboots where the power supply wasn't good
> enough.

This is the 3rd modell, currently 550W.
The system is P4 3G.

The another 2 stable node uses only 460W, and all hardware is equal.
But i tried to swap ps between the stable and unstabe nodes, but nothing is
changed....

Cheers,
Janos


>
> >
> > This is really a software bug, but i dont know exactly where.
>
> Could be. memtest doesn't guarantee anything though...
>
> -- 
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

