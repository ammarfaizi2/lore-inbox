Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVGXVoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVGXVoF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 17:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVGXVoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 17:44:04 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:25568 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261374AbVGXVoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 17:44:03 -0400
Date: Sun, 24 Jul 2005 23:43:45 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Grant Coady <lkml@dodo.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: xor as a lazy comparison
In-Reply-To: <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>
Message-ID: <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
 <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>To confuse you, coders with assembly or hardware background throw in 

I doubt that. I'm good enough assembly to see this :)

>equivalent bit operations to succinctly describe their visualisation 
>of solution space...  Perhaps the writer _wanted_ you to pause and 
>think?  Maybe the compiler produces better code?  Try it and see.

It produces a simple CMP. Should not be inefficient, though.


Jan Engelhardt
-- 
