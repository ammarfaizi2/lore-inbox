Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUD1U0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUD1U0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUD1UGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:06:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:654 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261704AbUD1Tb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:31:57 -0400
Date: Wed, 28 Apr 2004 12:29:18 -0700
From: "David S. Miller" <davem@redhat.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: jmorris@redhat.com, Matt_Domsch@dell.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/libcrc32c, revised 040428, with compiler.h included
Message-Id: <20040428122918.63dbfffc.davem@redhat.com>
In-Reply-To: <yqujhdv4kucn.fsf_-_@chaapala-lnx2.cisco.com>
References: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com>
	<yqujr7vai6k4.fsf@chaapala-lnx2.cisco.com>
	<200403302043.22938.bzolnier@elka.pw.edu.pl>
	<yqujwu52ywsy.fsf@chaapala-lnx2.cisco.com>
	<20040330192350.GB5149@lists.us.dell.com>
	<yquj1xn87mpy.fsf_-_@chaapala-lnx2.cisco.com>
	<yqujpta3y7ia.fsf_-_@chaapala-lnx2.cisco.com>
	<20040423164226.3d6fa2c3.davem@redhat.com>
	<yqujoepd9pb8.fsf_-_@chaapala-lnx2.cisco.com>
	<20040427124906.6bb753eb.davem@redhat.com>
	<yqujbrld9oou.fsf@chaapala-lnx2.cisco.com>
	<yquj3c6p9jlq.fsf@chaapala-lnx2.cisco.com>
	<20040427145052.150b04bd.davem@redhat.com>
	<yqujhdv4kucn.fsf_-_@chaapala-lnx2.cisco.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004 10:14:32 -0500
Clay Haapala <chaapala@cisco.com> wrote:

> On Tue, 27 Apr 2004, David S. Miller stated:
> > On Tue, 27 Apr 2004 16:49:53 -0500
> > Clay Haapala <chaapala@cisco.com> wrote:
> > 
> >> Is it accepted form to add the include line even so?
> > 
> > Yes, it only works today because those other headers include it.
> 
> OK, below is the patch with compiler.h included.

Looks great, patch applied.

Thanks.
