Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316877AbSE3VGh>; Thu, 30 May 2002 17:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316881AbSE3VGg>; Thu, 30 May 2002 17:06:36 -0400
Received: from mta3n.bluewin.ch ([195.186.1.212]:3240 "EHLO mta3n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S316877AbSE3VGf>;
	Thu, 30 May 2002 17:06:35 -0400
Message-ID: <3CF69444.2080503@bluewin.ch>
Date: Thu, 30 May 2002 23:06:12 +0200
From: Nicolas Aspert <Nicolas.Aspert@bluewin.ch>
Reply-To: Nicolas.Aspert@epfl.ch
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: skidley@crrstv.net, Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH*]2.4.19-pre9-ac2 agp compile error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

There was a few typos in the patch I sent to the list previously. A 
remaining '&'  from a cut'n paste and INTEL_I815_APCONT instead of 
INTEL_815_APCONT

The full correct patch for Intel815 (against 2.4.19-pre8-ac5, but easily 
adaptable to 2.4.19-pre9-ac2) is available at 
http://ltswww.epfl.ch/~aspert/patches/patch-intel_815-2.4.19-pre8-ac5

The rest *should* be OK, please test.

I wish I had a dedicated computer on which I could compile all this 
stuff... Maybe one day ;-)

Best regards



