Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVDNUBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVDNUBK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVDNUBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:01:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35076 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261484AbVDNUBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:01:02 -0400
Date: Thu, 14 Apr 2005 22:01:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Franco Sensei <senseiwa@tin.it>
Cc: David Lang <dlang@digitalinsight.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
Message-ID: <20050414200101.GC3628@stusta.de>
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de> <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it> <Pine.LNX.4.62.0504121053583.17233@qynat.qvtvafvgr.pbz> <425E9FE2.6090102@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425E9FE2.6090102@tin.it>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 11:52:50AM -0500, Franco Sensei wrote:
>...
> An advantage is the total freedom about the code. Ok, I know. But as 
> long as the kernel grows, in size and in its use, something more should 
> be considered. ABI is a step forward companies and people like me in 
> handling linux easily. API and data structure stability should be 
> something in mind, since breaking compatibility from 2.6.8 to 2.6.8.1 
> causes big troubles to anyone who's mantaining many machines. And if you 
>...

Are you sure you know what you are talking about?

ABI stability requires API stability [1].

cu
Adrian

[1] you can break the API without breaking the ABI, but these are
    mostly pathological examples

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

