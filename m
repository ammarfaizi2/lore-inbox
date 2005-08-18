Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVHRKse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVHRKse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 06:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVHRKse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 06:48:34 -0400
Received: from dns.toxicfilms.tv ([150.254.220.184]:51941 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S932175AbVHRKse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 06:48:34 -0400
X-QSS-TOXIC-Mail-From: solt2@dns.toxicfilms.tv via dns
X-QSS-TOXIC: 1.25st (Clear:RC:1(213.238.97.46):. Processed in 0.102501 secs Process 3387)
Date: Thu, 18 Aug 2005 12:48:35 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <761879244.20050818124835@dns.toxicfilms.tv>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() makes OpenLDAP slow
In-Reply-To: <200508181047.26008.kernel@kolivas.org>
References: <4303DB48.8010902@develer.com>
 <200508181047.26008.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Con,

Thursday, August 18, 2005, 2:47:25 AM, you wrote:
> sched_yield behaviour changed in 2.5 series more than 3 years ago and
> applications that use this as a locking primitive should be updated.
I remember open office had a problem with excessive use of sched_yield()
during 2.5. I guess they changed it but I have not checked.
Does anyone know ?

Back then oo was having serious latency problems on 2.5

Regards,
Maciej


