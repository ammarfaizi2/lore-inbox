Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVFAFRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVFAFRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVFAFRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:17:36 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:16550 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261276AbVFAFPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 01:15:16 -0400
Message-ID: <429D4459.2060206@m1k.net>
Date: Wed, 01 Jun 2005 01:15:05 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mauro Carvalho Chehab <maurochehab@gmail.com>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Video for Linux Docummentation
References: <429D2A7C.1080002@gmail.com>
In-Reply-To: <429D2A7C.1080002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab wrote:

>This patch synchronizes documentation from V4L CVS with current kernel
>release.
>
>  
>
Andrew-

My fix-for-cx88-cardsc-for-dvico-fusionhdtv-3-gold-q.patch in -mm 
conflicts with the Video for Linux Documentation patch.  I think you 
should just drop my patch, since it's in v4l cvs as card=28 (instead of 
card=27, in -mm).  I guess it will get into the kernel when the rest of 
v4l synchronizes.

Thanks

-- 
Michael Krufky

