Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312203AbSCRGDW>; Mon, 18 Mar 2002 01:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312204AbSCRGDN>; Mon, 18 Mar 2002 01:03:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29962 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312203AbSCRGC7>;
	Mon, 18 Mar 2002 01:02:59 -0500
Message-ID: <3C9582F0.7090102@mandrakesoft.com>
Date: Mon, 18 Mar 2002 01:02:24 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Another entry for the MCE-hang list
In-Reply-To: <200203180546.g2I5kP412586@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

>  Hi, all. I just booted 2.4.19-pre3, and it hung right after the MCE
>message. This is an Asus P2B-D with two Intel 450 MHz PIII's. Output
>of /proc/cpuinfo appended.
>

My ASUS P2B-D with dual P-II 400's is strange...

I -was- getting the hang, but then I recompiled on a different host, 
with possibly a different compiler, and the hang went away.  Sorry I 
cannot be more specific than this :(

The "running ok" case, which came -after- the hang case, was 
2.4.19-pre3-BK-latest with gcc 3.0.4-MDK.

    Jeff




