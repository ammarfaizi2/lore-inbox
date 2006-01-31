Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWAaMHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWAaMHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 07:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWAaMHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 07:07:39 -0500
Received: from penta.pentaserver.com ([66.45.247.194]:21411 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1750774AbWAaMHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 07:07:39 -0500
Message-ID: <43DF4F8A.6090705@gmail.com>
Date: Tue, 31 Jan 2006 15:52:42 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Kerin Millar <kerframil@gmail.com>
CC: stable@kernel.org, manu@linuxtv.org, dsd@gentoo.org, plasmaroo@gentoo.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Johannes Stezenbach <js@linuxtv.org>, Adrian Bunk <bunk@stusta.de>,
       security@kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [CVE-2005-4639] Re: [PATCH 2.6.14] dvb: dst: Fix possible buffer
 overflow
References: <279fbba40601301556g6aeae646i@mail.gmail.com>
In-Reply-To: <279fbba40601301556g6aeae646i@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kerin Millar wrote:
> Hi,
>
> please consider this fix for 2.6.14.7. It's a security fix for
> CVE-2005-4639. If it's too late then please queue for the next release
> if applicable.
>
> Thanks,
>
> --Kerin
>
> PS: a few of the recipients may have received a copy without the
> attachment. Apologies for the noise in that case.
>   

Acked-by: Manu Abraham <manu@linuxtv.org>


Manu

