Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284636AbRLPLp3>; Sun, 16 Dec 2001 06:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284615AbRLPLpU>; Sun, 16 Dec 2001 06:45:20 -0500
Received: from ns.suse.de ([213.95.15.193]:57092 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284584AbRLPLpG>;
	Sun, 16 Dec 2001 06:45:06 -0500
Date: Sun, 16 Dec 2001 12:45:01 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][OOPS] loop block device induced on 2.5.1-pre11+HIGHMEM
In-Reply-To: <Pine.LNX.4.33.0112161017550.4185-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0112161238110.876-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2001, Zwane Mwaikambo wrote:

> Then again, is highmem kernel on non-highmem box a valid configuration?

Andrea had patches that allowed such a configuration. Better still,
it could be used for debugging highmem problems on boxes without highmem.

I thought this stuff had been merged, maybe it was only -aa, or -ac.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

