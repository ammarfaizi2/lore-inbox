Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUCRHJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 02:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbUCRHJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 02:09:15 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:49842 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S262439AbUCRHJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 02:09:08 -0500
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong
	thing
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Reply-To: christian.guggenberger@physik.uni-regensburg.de
To: peterw@aurema.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1079593351.1830.12.camel@bonnie79>
References: <1079593351.1830.12.camel@bonnie79>
Content-Type: text/plain
Message-Id: <1079593734.1830.17.camel@bonnie79>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 08:08:54 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 08:02, Christian Guggenberger wrote:
> >With 2.6.4 I'm getting the following messages very early in the boot 
> >long before XFree86 is started:
> >

oops, must have overlook this sentence before - should get a coffee
first. Well in that case, XFree86 should not have been blamed.
sorry for the noise.

> >Mar 18 16:05:31 mudlark kernel: atkbd.c: Unknown key released 
> >(translated set 2, code 0x7a on isa0060/serio0).
> >Mar 18 16:05:31 mudlark kernel: atkbd.c: This is an XFree86 bug. It 
> >shouldn't access hardware directly.
> >
> >They are repeated 6 times and are NOT the result of any keys being 
> >pressed or released.
> 
> this has been fixed in XFree86 HEAD (4.4.99.1)
> see changelog entry nr. 6 - the changes can easily be backported to 4.3.0, and work as expected on my box.
> (no noise anymore)
> 



