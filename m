Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSBFKRF>; Wed, 6 Feb 2002 05:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290062AbSBFKQs>; Wed, 6 Feb 2002 05:16:48 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:42126 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S288958AbSBFKQg>;
	Wed, 6 Feb 2002 05:16:36 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Generic HDLC patch for 2.5.3
In-Reply-To: <20020202190242.C1740@havoc.gtf.org>
	<E16XAnc-00010K-00@the-village.bc.nu>
	<20020202200332.A3740@havoc.gtf.org>
	<20020203181302.C12963@fafner.intra.cogenit.fr>
	<20020203124614.A10139@havoc.gtf.org>
	<20020203230652.D12963@fafner.intra.cogenit.fr>
	<m3g04h5rpn.fsf@defiant.pm.waw.pl>
	<20020204191150.A11131@fafner.intra.cogenit.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 05 Feb 2002 13:11:01 +0100
In-Reply-To: <20020204191150.A11131@fafner.intra.cogenit.fr>
Message-ID: <m33d0gxh62.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@cogenit.fr> writes:

> hdlc with address and command unspecified looks "raw" to me.

Sure, but its raw HDLC and not just "raw". By HDLC I mean flags, CRCs,
bit stuffing etc (for async transmission at least).

> -> raw_hdlc ?

Ok.
-- 
Krzysztof Halasa
Network Administrator
