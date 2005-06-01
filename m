Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVFAK02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFAK02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 06:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVFAK02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 06:26:28 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:3561 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261155AbVFAK00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 06:26:26 -0400
References: <1117291619.9665.6.camel@localhost>
            <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
            <84144f0205052911202863ecd5@mail.gmail.com>
            <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
            <1117399764.9619.12.camel@localhost>
            <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
            <1117466611.9323.6.camel@localhost>
            <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
            <courier.429C05C1.00005CC5@courier.cs.helsinki.fi>
            <20050601073544.GA21384@elte.hu>
In-Reply-To: <20050601073544.GA21384@elte.hu>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TASK_NONINTERACTIVE (was: Machine Freezes while Running Crossover Office)
Date: Wed, 01 Jun 2005 13:26:25 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.429D8D51.00005B9C@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On Wed, 2005-06-01 at 09:35 +0200, Ingo Molnar wrote:
> Pekka, could you check whether the patch below solves your Wine problem 
> (without hurting interactivity otherwise)?

I have been running a patched 2.6.12-rc5 for over an hour now with no 
interactivity problems whatsoever (although on a different laptop). I am 
using Eclipse, Tomcat, XMMS, Firefox, and Evolution. From my POV, this is 
2.6.12 and -stable material. Thanks! 

                   Pekka 
