Return-Path: <linux-kernel-owner+w=401wt.eu-S965009AbXADQP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbXADQP4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbXADQP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:15:56 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:54483 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965009AbXADQPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:15:54 -0500
Date: Thu, 4 Jan 2007 17:15:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Add const for time{spec,val}_compare arguments
In-Reply-To: <200701041659.13532.eike-kernel@sf-tec.de>
Message-ID: <Pine.LNX.4.61.0701041714350.28835@yvahk01.tjqt.qr>
References: <200701041659.13532.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 4 2007 16:59, Rolf Eike Beer wrote:
>From: Rolf Eike Beer <eike-kernel@sf-tec.de>
>To: linux-kernel@vger.kernel.org
>Cc: Andrew Morton <akpm@osdl.org>
>Subject: [PATCH] Add const for time{spec,val}_compare arguments
>
>The arguments are really const. Mark them const to allow these functions
>being called from places where the arguments are const without getting
>useless compiler warnings.
>
>Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>


It's already been done: http://lkml.org/lkml/2006/7/27/299
Now, I wonder why it got not merged yet.


	-`J'
-- 
