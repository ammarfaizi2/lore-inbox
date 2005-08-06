Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVHFKkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVHFKkU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 06:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVHFKkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 06:40:20 -0400
Received: from hermes.domdv.de ([193.102.202.1]:10255 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262049AbVHFKkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 06:40:18 -0400
Message-ID: <42F49382.1070809@domdv.de>
Date: Sat, 06 Aug 2005 12:40:02 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cal Peake <cp@absolutedigital.net>
CC: Andrew Morton <akpm@osdl.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, pavel@suse.cz,
       davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
References: <42DD67D9.60201@stud.feec.vutbr.cz> <20050804142548.5b813700.akpm@osdl.org> <Pine.LNX.4.61.0508041741540.4557@lancer.cnet.absolutedigital.net> <42F34022.9040201@domdv.de> <Pine.LNX.4.61.0508051835210.28261@lancer.cnet.absolutedigital.net>
In-Reply-To: <Pine.LNX.4.61.0508051835210.28261@lancer.cnet.absolutedigital.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake wrote:
> On Fri, 5 Aug 2005, Andreas Steinmetz wrote:
> 
> 
>>AFAIK it works when agp is built into the kernel. You will get problems
>>when it is built as a module. In the module case you may want to try if
>>loading the module before resuming helps.
> 
> 
> Strange. I've had it built as a module from day one and never had a 
> problem resuming.

I guess it depends on what the BIOS does.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
