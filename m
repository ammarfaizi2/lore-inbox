Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbUCRPlU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbUCRPlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:41:20 -0500
Received: from peabody.ximian.com ([130.57.169.10]:4070 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262695AbUCRPlQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:41:16 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Robert Love <rml@ximian.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, "Marinos J. Yannikos" <mjy@geizhals.at>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <s5hlllycgz3.wl@alsa2.suse.de>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random>  <s5hlllycgz3.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1079624457.2136.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 18 Mar 2004 10:40:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 10:28, Takashi Iwai wrote:

Hi, Takashi Iwai.

> well, i personally am not against the current preempt mechanism from
> the viewpoint of the audio-processing purpose :)  the implementation
> is relatively clean and easy.

Agreed.

> i think the first one is needed for preemptive kernel, too.
> with these patches, also 0.1-0.2ms RT-latency is achieved.

Ohh, interesting.  I'll give these a spin with PREEMPT=y and see.  Thank
you!

	Robert Love


