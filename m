Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbTAXXFX>; Fri, 24 Jan 2003 18:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAXXFX>; Fri, 24 Jan 2003 18:05:23 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:22734 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265736AbTAXXFW>;
	Fri, 24 Jan 2003 18:05:22 -0500
Subject: Re: [RFC][PATCH] linux-2.5.59_lost-tick_A0
From: john stultz <johnstul@us.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1043449992.10150.29.camel@dell_ss3.pdx.osdl.net>
References: <1043189962.15683.82.camel@w-jstultz2.beaverton.ibm.com>
	 <1043449992.10150.29.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1043449581.1028.0.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Jan 2003 15:06:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-24 at 15:13, Stephen Hemminger wrote:
> Minor nit: detect_lost_tick could be static and inline.

Good point, I'll fix that before my next release. 

Thanks for the feedback!
-john


