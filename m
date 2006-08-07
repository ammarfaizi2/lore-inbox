Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWHGHkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWHGHkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 03:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWHGHki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 03:40:38 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:39377 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751141AbWHGHkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 03:40:37 -0400
Date: Mon, 7 Aug 2006 09:34:43 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
cc: Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native
 ops
In-Reply-To: <20060807062705.GB4979@rhun.haifa.ibm.com>
Message-ID: <Pine.LNX.4.61.0608070934030.12594@yvahk01.tjqt.qr>
References: <1154925835.21647.29.camel@localhost.localdomain>
 <200608070730.17813.ak@muc.de> <1154930669.7642.12.camel@localhost.localdomain>
 <200608070817.42074.ak@muc.de> <20060807062705.GB4979@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>baremetal.h seems appropriate.

<vanilla.h>, in hommage to "vanilla kernel".



Jan Engelhardt
-- 
