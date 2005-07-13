Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVGMWMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVGMWMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVGMWJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:09:35 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45709 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262794AbVGMWIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 18:08:17 -0400
Message-Id: <200507132205.j6DM5WJg020905@laptop11.inf.utfsm.cl>
To: Greg KH <gregkh@suse.de>
cc: suresh.b.siddha@intel.com, ak@suse.de, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [11/11] x86_64: TASK_SIZE fixes for compatibility mode processes 
In-Reply-To: Message from Greg KH <gregkh@suse.de> 
   of "Wed, 13 Jul 2005 11:44:26 MST." <20050713184426.GM9330@kroah.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 13 Jul 2005 18:05:32 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 13 Jul 2005 18:05:33 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> Cc: Andi Kleen <ak@muc.de>

Huh? Cc: in here?

> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Chris Wright <chrisw@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
