Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUGMAQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUGMAQB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUGMAQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:16:00 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:15235 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S264512AbUGMAP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:15:28 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Preempt Threshold Measurements
Date: Mon, 12 Jul 2004 20:15:27 -0400
User-Agent: KMail/1.6.2
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
References: <200407121943.25196.devenyga@mcmaster.ca> <cone.1089676751.66009.12958.502@pc.kolivas.org>
In-Reply-To: <cone.1089676751.66009.12958.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407122015.27971.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using snapshot-2.6.8-rc1-ck5-0407130047

On Monday 12 July 2004 19:59, Con Kolivas wrote:
> Gabriel Devenyi writes:
> > Keeping in mind that I'm using the nvidia-kernel drivers, here are my
> > preempt threshold violations.
>
> Hi.
>
> Thanks for those. Can you confirm which version of the preempt threshold
> patch you're using? The first one I posted unfortunately had false
> positives. Those results unfortunately look like the first patch.
>
> You would have to be using either wli_preempttest2 + 2.1 separate patches
> or the snapshot-2.6.8-rc1-ck5-0407130047 or later which includes these
> patches for more accurate timekeeping (sorry).
>
> Cheers,
> Con

-- 
Gabriel Devenyi
devenyga@mcmaster.ca
