Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280190AbRJaNBg>; Wed, 31 Oct 2001 08:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280191AbRJaNB0>; Wed, 31 Oct 2001 08:01:26 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:14857 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S280190AbRJaNBR>;
	Wed, 31 Oct 2001 08:01:17 -0500
Message-ID: <3BDFF640.4020002@epfl.ch>
Date: Wed, 31 Oct 2001 14:01:52 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: i820 agp support ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

It seems to me that the i820 chipset from Intel, which I have on my PC, 
is not supported by the 'agpgart' module. Looking at the source (from 
2.4.13) shows that there is support for i810, i815 and then skips to i830.
I have managed to use the module successfully with the nice 
'agp_try_unsupported=1' option (with a kernel 2.4.9 from RedHat), but 
still something remain unclear to me, namely "why is the i820 still in 
the 'unsupported' hardware ?".

Are there many major differences between i820 and the other Intel 
chipsets ?

Thanks in advance for answering.

Best regards.

Nicolas.

PS: please CC to me your answers/comments since I am not subscribed to 
the list.
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)
Office:  ELE 237


