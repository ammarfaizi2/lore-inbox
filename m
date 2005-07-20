Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVGTEjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVGTEjo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 00:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVGTEjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 00:39:44 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:11711 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261709AbVGTEjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 00:39:43 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Gabriel Devenyi <ace@staticwave.ca>
Subject: Re: amd64 Interbench Results
Date: Wed, 20 Jul 2005 14:42:10 +1000
User-Agent: KMail/1.8.1
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
References: <200507192246.31314.ace@staticwave.ca>
In-Reply-To: <200507192246.31314.ace@staticwave.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507201442.10679.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2005 12:46 pm, Gabriel Devenyi wrote:
> I've been using the the -ck patchset for a very long time, and I recently
> switched to a amd64 arch. I found that while my throughput improved, my
> system responsiveness has "felt" much lower than it did on my old x86
> machine.
>
> Now that interbench is around, I have some quantitative results. Attached
> is my interbench results with *nothing* running other than agetty and a
> single bash console. My system is an AMD Athlon(tm) 64 Processor 3200+,
> with 1gig DDR400 RAM. Also attached is my kernel config.
>
> Seems to me there are some pretty high latencies for such a powerful
> system, is there anything I can do to improve this? Thanks for all your
> help.

Those results don't look too bad to me. Absolute numbers don't mean much in 
their own right unless you compare them to something else. Try a vanilla 
kernel and then compare the results side by side.

Cheers,
Con
