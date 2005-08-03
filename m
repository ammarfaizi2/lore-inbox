Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVHCMIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVHCMIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 08:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVHCMFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 08:05:43 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:34008 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262253AbVHCMEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 08:04:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Gabriel Devenyi <ace@staticwave.ca>
Subject: Re: [ck] [ANNOUNCE] Interbench v0.26
Date: Wed, 3 Aug 2005 22:03:44 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       Jake Moilanen <moilanen@austin.ibm.com>
References: <200508031758.31246.kernel@kolivas.org> <42F0B223.20404@staticwave.ca>
In-Reply-To: <42F0B223.20404@staticwave.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508032203.44795.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005 22:01, Gabriel Devenyi wrote:
> You haven't quite completely fixed the SD calculations it seems:
>
>
> --- Benchmarking simulated cpu of Gaming in the presence of simulated---
> Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
> None       2.44 +/- nan         48.6            98.7
> Video      12.8 +/- nan         55.2              89
> X          89.7 +/- nan          494            52.8
> Burn        400 +/- nan         1004            20.1
> Write      49.2 +/- nan          343            67.2
> Read       4.14 +/- nan         56.7            96.7
> Compile     551 +/- nan         1369            15.4

>:(

I keep trying

Con
