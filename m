Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUC3PVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263719AbUC3PVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:21:47 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:60363 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263714AbUC3PV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:21:26 -0500
Message-ID: <001101c41669$0f7acde0$fc82c23f@pc21>
From: "Ivan Godard" <igodard@pacbell.net>
To: "Pavel Machek" <pavel@suse.cz>, "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
References: <048e01c413b3_3c3cae60_fc82c23f@pc21.suse.lists.linux.kernel> <p73y8pm951k.fsf@nielsen.suse.de> <07b501c41502_48bd4d20_fc82c23f@pc21> <20040329011416.591ad315.ak@suse.de> <20040329153606.GA3084@openzaurus.ucw.cz>
Subject: Re: Kernel support for peer-to-peer protection models...
Date: Tue, 30 Mar 2004 07:09:41 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Pavel Machek" <pavel@suse.cz>
To: "Andi Kleen" <ak@suse.de>
Cc: "Ivan Godard" <igodard@pacbell.net>; <linux-kernel@vger.kernel.org>
Sent: Monday, March 29, 2004 7:36 AM
Subject: Re: Kernel support for peer-to-peer protection models...


> Hi!
>
> > > > Overall it sounds like your architecture is not very well suited to
> > > > run Linux.
> > >
> > > We believe we can adopt the Linux protection model (i.e. the 386
protection
> > > model) with no more work than any other port to a new architectire
(ahem).
> >
> > Just FYI - Linux has been ported to several architectures with similar
SASOS
> > capabilities in hardware (IA64 or ppc64 on iseries) and they have all
opted to use
> > an conventional protection model.
> >
>
> It might be actually plus for Ivan: if ia64 and ppc64 benefit from
> changes for mill, it makes them more acceptable.


Interesting point. Although it's not clear how long ia64 will still exist.
Remember the Alpha?

Ivan


