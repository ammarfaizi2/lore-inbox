Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUFQAjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUFQAjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 20:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266314AbUFQAjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 20:39:16 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:54147 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264639AbUFQAjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 20:39:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Panagiotis Papadakos <papadako@csd.uoc.gr>
Subject: Re: [PATCH] Stairacse scheduler v6.E for 2.6.7-rc3
Date: Thu, 17 Jun 2004 10:39:06 +1000
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <1087333441.40cf6441277b5@vds.kolivas.org> <40D044BA.4080009@kolivas.org> <Pine.GSO.4.58.0406170250430.8103@thanatos.csd.uoc.gr>
In-Reply-To: <Pine.GSO.4.58.0406170250430.8103@thanatos.csd.uoc.gr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406171039.06601.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 09:54, Panagiotis Papadakos wrote:
> UT2004 works just fine here on a 2.6.7-rc3-mm2 with s6.E!
> By the way great work Con!

Great!

> P.S.
> There is some problem with the patch for the mm2.
> All hunks succeeded but somehow there was a compilation error in
> kernel/sched.c. After commenting out the following line I was able to
> compile the kernel: line 118:
> /*prio_array_t *active, *expired, arrays[2];*/

Sorry the -mm patches are contributed. I may move to doing them myself soon.

Con
