Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290924AbSASIdS>; Sat, 19 Jan 2002 03:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290925AbSASIdJ>; Sat, 19 Jan 2002 03:33:09 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:29713 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S290924AbSASIcx>;
	Sat, 19 Jan 2002 03:32:53 -0500
Message-ID: <3C492F31.7020200@epfl.ch>
Date: Sat, 19 Jan 2002 09:32:49 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Daniele Venzano <venza@iol.it>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AGP update for i820 and i860 chipsets
In-Reply-To: <20020118221153.GA1263@renditai.milesteg.arr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Venzano wrote:

> This patch fixes the ID for i860 chipset and adds support for the UP
> version of i820 AGP bridge. I made it against kernel 2.4.17. It compiles
> and works both builin or as a module.
> 
> It was submitted long ago by Nicolas Aspert and works well for
> me, I'm running XFree with DRI and AGP 4x without problems.
> 
> This is my first patch, so there could be problems, however you could
> find it also at:
> http://digilander.iol.it/webvenza/agp_patch.html
> 
> Best regards.
> 
> 

Hello Daniele

In fact, the patch you sent went into 2.4.18-pre2, along with my 830MP 
stuff (which missed the suspend/resume), so it should be OK in the next 
releases.

I am now doing the corrective patch for the suspend/resume stuff.

Best regards

Nicolas
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)
Office:  ELE 237
Phone:   +41 - 21 - 693 36 32 (LTS Office)
Fax:     +41 - 21 - 693 76 00  Web: http://ltswww.epfl.ch/~aspert

