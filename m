Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278042AbRKMS3A>; Tue, 13 Nov 2001 13:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278098AbRKMS2u>; Tue, 13 Nov 2001 13:28:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30737 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278042AbRKMS2i>; Tue, 13 Nov 2001 13:28:38 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: fdutils.
Date: 13 Nov 2001 10:28:03 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9sronj$pna$1@cesium.transmeta.com>
In-Reply-To: <E04CF3F88ACBD5119EFE00508BBB21216C828E@exch-01.noida.hcltech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E04CF3F88ACBD5119EFE00508BBB21216C828E@exch-01.noida.hcltech.com>
By author:    Rajiv Malik <rmalik@noida.hcltech.com>
In newsgroup: linux.dev.kernel
>
> hi again, 
> still no answer to my previous query.i think nobuddy knows the answer.
> nehowwe we will solve it other way.
> 
> does linux floppy driver support super drives (LS-120/LS-240)
> 

Not the traditional floppy driver, but rather the ide-floppy driver
(which is a different driver.)

Thankfully, the LS-120/LS-240 hardware is actually sane.
Unfortunately the zip drive probably kept it from displacing legacy
floppies, at least in the short term.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
