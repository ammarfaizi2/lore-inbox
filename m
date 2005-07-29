Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVG2Lan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVG2Lan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVG2L23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 07:28:29 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:26059 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262524AbVG2L1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 07:27:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Gabriel Devenyi <ace@staticwave.ca>
Subject: Re: [ck] [ANNOUNCE] Interbench v0.24
Date: Fri, 29 Jul 2005 21:27:25 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200507291310.42203.kernel@kolivas.org> <42EA0EF8.2040202@staticwave.ca>
In-Reply-To: <42EA0EF8.2040202@staticwave.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507292127.25529.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 21:11, Gabriel Devenyi wrote:
> Hello Con,
>
> Attempting to run this on my 2.6.12-ck3s system results in the following
> error:
>
> sawtooth interbench-0.24 # ./interbench
> loops_per_ms unknown; benchmarking...
> 690936 loops_per_ms saved to file interbench.loops_per_ms
>
> Could not get memory or swap size
>
> Bug perhaps? My configuration hasn't changed since interbench 0.23 AFAIK.

No swap?

Cheers,
Con
