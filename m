Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUHDUHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUHDUHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267402AbUHDUHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:07:01 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43000 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267403AbUHDUGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:06:55 -0400
Message-Id: <200408042007.i74K77R30880@owlet.beaverton.ibm.com>
To: Andrew Morton <akpm@osdl.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?) 
In-reply-to: Your message of "Wed, 04 Aug 2004 12:50:05 PDT."
             <20040804125005.544e9304.akpm@osdl.org> 
Date: Wed, 04 Aug 2004 13:07:07 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Ho hum.  It's up to the hordes of scheduler hackers really.  If they
    want, and can agree upon a patch then go wild.  It should be against
    -mm minus staircase, as there's a fair amount of scheduler stuff
    banked up for post-2.6.8.

The patch exists for both -mm2 and -mm1, but I've been holding off
posting it until I get a chance to do more than simply compile it.
Our lab machines are back up now so I'll test a (-mm2 - staircase)
patch this afternoon.

Rick
