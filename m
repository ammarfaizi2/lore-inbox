Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVKLDHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVKLDHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 22:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVKLDHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 22:07:43 -0500
Received: from student.if.pw.edu.pl ([194.29.174.5]:2493 "EHLO
	tleilax.if.pw.edu.pl") by vger.kernel.org with ESMTP
	id S1751092AbVKLDHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 22:07:42 -0500
Date: Sat, 12 Nov 2005 04:07:36 +0100 (CET)
From: Marek Szuba <cyberman@if.pw.edu.pl>
To: Takashi Iwai <tiwai@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA in 2.6.14: RTC timer breaks MIDI
In-Reply-To: <s5hpsp7z39n.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.62.0511120405470.27232@gyrvynk.vs.cj.rqh.cy>
References: <Pine.LNX.4.62.0511101735350.30579@gyrvynk.vs.cj.rqh.cy>
 <s5hpsp7z39n.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Takashi Iwai wrote:

> A known problem.  Try the patch below.
Works like a charm now, thanks.

-- 
MS
