Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUCKRiG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 12:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUCKRiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 12:38:05 -0500
Received: from weird-brew.cisco.com ([144.254.15.118]:45541 "EHLO
	strange-brew.cisco.com") by vger.kernel.org with ESMTP
	id S261451AbUCKRiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 12:38:02 -0500
Message-ID: <4050A3ED.30603@skynet.be>
Date: Thu, 11 Mar 2004 18:37:49 +0100
From: Anjinsan <anjinsan@skynet.be>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: lufs removed from 2.6.4 kernel?
References: <40505060.1020902@skynet.be> <20040311080906.077b9ea0.rddunlap@osdl.org>
In-Reply-To: <20040311080906.077b9ea0.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for bringing up the patch question. It made me think, and after scanning
my 2.6.3 build directory, there it was:
lufs-0.9.7-2.6.0-test9.patch

So I guess this explain why I didn't see it in 2.6.4. My sincere apologies.


Randy.Dunlap wrote:
> On Thu, 11 Mar 2004 12:41:20 +0100 Anjinsan wrote:
> 
> | 
> | Hi,
> | 
> | it seems that (even with "prompt for development and/or incomplete code/drivers" enabled,
> | and "select only drivers selected to compile cleanly" & "select only drivers that don't need extra ..."
> | disabled) lufs is no longer in File Systems -> Miscellaneous filesystems.
> | Is this on purpose? It was still there in 2.6.3.
> 
> I'm having trouble seeing lufs in 2.6.3 or 2.6.4 or 2.6.1...
> 
> Exactly what kernel do you find it in?  Any patches applied to it?
> 
> --
> ~Randy
> 
> 
