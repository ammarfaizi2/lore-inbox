Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTE2SeB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 14:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTE2SeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 14:34:01 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:32750 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S262490AbTE2Sd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 14:33:59 -0400
Message-ID: <3ED65593.1080401@cox.net>
Date: Thu, 29 May 2003 14:46:43 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Downing, Thomas" <Thomas.Downing@ipc.com>
CC: Thomas Molina <tmolina@cox.net>, Florin Iucha <florin@iucha.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Is ALSA broken in 2.5.70?
References: <170EBA504C3AD511A3FE00508BB89A920221E5F9@exnanycmbx4.ipc.com>
In-Reply-To: <170EBA504C3AD511A3FE00508BB89A920221E5F9@exnanycmbx4.ipc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Downing, Thomas wrote:
> -----Original Message-----
> From: David van Hoose [mailto:davidvh@cox.net]
> [snip]
> 
>>2.4.21-rc5. ALSA on 2.5.70-bk2 reported to be 0.9.2, but everyone says
>>it is 0.9.3c.
> 
> [snip]
> 
> Might the problem be incompatible versions of the alsa utilities and
> libs you are using with the alsa modules in the kernel?  I don't know,
> just a suggestion.  Feel free to flam...

I'm using alsa-lib 0.9.3, alsa-utils 0.9.3, alsa-tools 0.9.3 ALSA's OSS 
compatibility library 0.9.1.
For 2.4.21-rc5, I'm using 0.9.2 since 0.9.3 does not give me sound.
For 2.5.70-bk3, I'm using whatever is in it. I believe it is a version 
of 0.9.2, but I am not entirely sure.

Thanks,
David

