Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUKNEAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUKNEAl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 23:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbUKNEAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 23:00:41 -0500
Received: from user-0c99gdv.cable.mindspring.com ([24.148.193.191]:20097 "EHLO
	tuxq.com") by vger.kernel.org with ESMTP id S261239AbUKNEAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 23:00:38 -0500
Message-ID: <4196D865.3040203@tuxq.com>
Date: Sat, 13 Nov 2004 23:00:37 -0500
From: "Steven E. Woolard" <tuxq@tuxq.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040919
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem: 2.4.26/27 & 2.6.9 Audio CD Burning
References: <41960FC8.3040004@tuxq.com> <41961AC9.2070902@comcast.net>
In-Reply-To: <41961AC9.2070902@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> 2.6.9-ck2 works just fine burning audio cds.  I've had similar trouble 
> with the vanilla kernel burning audio cds.  I think some people even 
> mentioned ripping audio cds now doesn't use dma in vanilla.  I dont 
> really remember, just that whenever the vanilla kernel has had trouble 
> with audio and dma in 2.6, ck kernels have worked.

Well, I tried the ck3 patch ... no improvement. System load still goes 
crazy.

