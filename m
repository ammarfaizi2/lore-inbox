Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269850AbUH0BEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269850AbUH0BEc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269848AbUH0BA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:00:56 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:45214 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269850AbUH0A6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:58:16 -0400
Message-Id: <200408270058.i7R0wDV04916@owlet.beaverton.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Con Kolivas <kernel@kolivas.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1 
In-reply-to: Your message of "Thu, 26 Aug 2004 13:55:36 PDT."
             <52540000.1093553736@flay> 
Date: Thu, 26 Aug 2004 17:58:13 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Rick's schedstats stuff had some ways to measure latency that seemed to work
    quite nicely. Hard to simulate exactly mozilla, email, etc, but probably
    close enough to be far more use than "ooh, it feels faster".
    
    He did a whole paper at OLS ... Rick ... pointer?

http://www.finux.org/Reprints/Reprint-Lindsley-OLS2004.pdf

There are patches available for schedstats, although I haven't pulled
together 2.6.9-rc1 yet.  Shouldn't take me but fifteen minutes, I think.

Rafael, what baseline release are you comparing to?  I should be able
to provide some tools to measure the effect on updatedb directly for
both 2.6.9-rc1 and your baseline (so long as it's 2.6-based)

Rick
