Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWFSFY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWFSFY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 01:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWFSFY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 01:24:28 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:46265 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750726AbWFSFY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 01:24:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: tglx@timesys.com
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic  HZ
Date: Mon, 19 Jun 2006 15:24:04 +1000
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
References: <1150643426.27073.17.camel@localhost.localdomain> <200606191521.05508.kernel@kolivas.org>
In-Reply-To: <200606191521.05508.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191524.04846.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 15:21, Con Kolivas wrote:

> struct clock_event, the whole struct looks like a suitable candidate for
> __read_only.

duh

__read_mostly I mean

-- 
-ck
