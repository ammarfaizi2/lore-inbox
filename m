Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbRGDJTy>; Wed, 4 Jul 2001 05:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266547AbRGDJTo>; Wed, 4 Jul 2001 05:19:44 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:56335 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S266546AbRGDJTf>;
	Wed, 4 Jul 2001 05:19:35 -0400
Date: Wed, 4 Jul 2001 11:19:31 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Florian Schmitt <florian@galois.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
Message-ID: <20010704111931.A27723@se1.cogenit.fr>
In-Reply-To: <3B40611D.F1485C1B@N-Club.de> <01070311300700.00765@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01070311300700.00765@phoenix>; from florian@galois.de on Tue, Jul 03, 2001 at 11:31:42AM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmitt <florian@galois.de> ecrit :
[...]
> Same problem here, it won't run at all on newer kernels. But it isn't even 
> 100% stable in 2.2.x here - on very high network traffic the card stops 
> working. In this case, it helps to pull the network plug for a short time, 

Could you specify what you mean by "very high network traffic" in terms
of interrupt rate and Mb/s ? 
Ftp on full CD content or gross ping -f doesn't kill it under 2.4 here.
autonegociation sucks sometimes.

[...]
> then everything goes back to normal. I reduced speed to 10MB, and now it is 
> stable at least in 2.2.x. 
> Any suggestions would be greatly appreciated. I even put the card into 
> another pci slot with exactly zero effect.

Different switch/cable/*motherboard* ?

-- 
Ueimor
