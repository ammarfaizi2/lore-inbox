Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286233AbRLJLoP>; Mon, 10 Dec 2001 06:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286234AbRLJLoF>; Mon, 10 Dec 2001 06:44:05 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:46860 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S286233AbRLJLnz>;
	Mon, 10 Dec 2001 06:43:55 -0500
Message-ID: <3C149FF9.407@epfl.ch>
Date: Mon, 10 Dec 2001 12:43:53 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patches in 2.4.17-pre2 that aren't in 2.5.1-pre8
In-Reply-To: <linux.kernel.E16DNNu-0001VB-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all



> 
> In many cases that isnt true, and for a lot of the pending patches its
> pointless merging them into 2.5 until 2.5 gets into better shape. Going back
> over them as you have done is something that does need doing, but not until
> the block layer has some semblance of completion about it

Well I just saw the opposite ;-) ... A patch I had submitted a few weeks 
ago for Intel 830MP agp support has been intgrated in 2.5.1-pre3, but is 
still not in the 2.4 branch... Several users have reported success with 
this patch, so unless somebody shows storng opposition, I would suggest 
to merge it...
Get it here : http://ltswww.epfl.ch/~aspert/patches/patch-agp_i830mp-2.4.16

Best regards
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

