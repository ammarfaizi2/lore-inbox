Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUKSANo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUKSANo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUKSALk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:11:40 -0500
Received: from [213.188.213.77] ([213.188.213.77]:53165 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S261210AbUKSAKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:10:39 -0500
From: "Massimo Cetra" <mcetra@navynet.it>
To: "'Barry K. Nathan'" <barryn@pobox.com>, "'O.Sezer'" <sezeroz@ttnet.net.tr>
Cc: <linux-kernel@vger.kernel.org>, <marcelo.tosatti@cyclades.com>
Subject: RE: Linux 2.4.28-rc4
Date: Fri, 19 Nov 2004 01:10:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20041118204841.GA11682@ip68-4-98-123.oc.oc.cox.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcTNyelVzgCAOurJSiCJtYYW2pTlMAAAYxfw
Message-Id: <20041119001033.B25D48400A@server1.navynet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Marcelo and I discussed this via private e-mail; it's in the 
> queue for 2.4.29-pre. I think in the end we both agreed that 
> it's too late in the
> 2.4.28 cycle to include these patches.
> 
> -Barry K. Nathan <barryn@pobox.com>

Why such a decision ?

Do you think that it is not exploitable or at least not in a short time ?

I don't think 2.4.29 will see the light in a short time so, unless there are
serious problems arising from these patches (and 2.6 should be affected
too), I think that for the sake of security it may be worthy and clever
includind these patches (and delay 2.4.28 for some days...)

M$ is waiting for a gold occasion to shot on linux. 
A known buffer overflow, not patched soon, may be used against linux and,
what interest me more, we could avoid updating kernels on tons pf production
servers for something which could be patched before.

Massimo Cetra

