Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVDEPAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVDEPAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVDEPAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:00:52 -0400
Received: from hades.almg.gov.br ([200.198.60.36]:40322 "EHLO
	hades.almg.gov.br") by vger.kernel.org with ESMTP id S261771AbVDEPAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:00:41 -0400
Message-ID: <4252A821.9030506@almg.gov.br>
Date: Tue, 05 Apr 2005 12:00:49 -0300
From: Humberto Massa <humberto.massa@almg.gov.br>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050224)
MIME-Version: 1.0
To: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 	copyright notice.
References: <lLj-vC.A.92G.w4pUCB@murphy>
In-Reply-To: <lLj-vC.A.92G.w4pUCB@murphy>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josselin Mouette wrote:

>You are mixing apples and oranges. The fact that the GFDL sucks has
>nothing to do with the firmware issue. With the current situation of
>firmwares in the kernel, it is illegal to redistribute binary images of
>the kernel. Full stop. End of story. Bye bye. Redhat and SuSE may still
>be willing to distribute such binary images, but it isn't our problem.
>  
>
Yes, GFDL has nothing to do with the main issue. No, it is not 
necessarily illegal to redistribute binary images of the kernel as they 
are today (see below). The first problem is that they (the complete 
w/firmware kernel binary images) are not DFSG-free, anyway. The second 
problem is that some firmware blobs don't have explicitly stated in the 
kernel tree which exactly are their licensing terms for redistribution 
-- those are, in principle, undistributable.

>Putting the firmwares outside the kernel makes them distributable. Some
>distributions will want to include them, some others not. But the
>important point is that it makes that redistribution legal.
>  
>
If putting the firmwares outside the kernel makes *them* distributable, 
then the binary kernel image is already distributable -- just not 
DFSG-free. The important fact WRT Debian, IMHO, is that putting the 
firmwares outside the kernel makes the kernel binary image DFSG-free.

HTH,
Massa

