Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313819AbSEEXfA>; Sun, 5 May 2002 19:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313827AbSEEXfA>; Sun, 5 May 2002 19:35:00 -0400
Received: from mnh-1-26.mv.com ([207.22.10.58]:8 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S313819AbSEEXe7>;
	Sun, 5 May 2002 19:34:59 -0400
Message-Id: <200205060036.TAA03815@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: hugang <gang_hu@soul.com.cn>
cc: glonnon@ridgerun.com, Pavel Machek <pavel@suse.cz>, seasons@fornax.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATH] Port software to UML. 
In-Reply-To: Your message of "Sun, 05 May 2002 21:48:19 +0800."
             <20020505214819.19cb9a86.gang_hu@soul.com.cn> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 May 2002 19:36:44 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gang_hu@soul.com.cn said:
>   Now I try port software to UML(user mode linux). 

I should have mentioned in my last message that swsusp would be very cool
to port to UML and I'd love to see it working.  There are lots of interesting
things that you'd be able to do as a result.

You just need to understand UML internals enough to save and restore all
of UML's host state, not just the memory image.

				Jeff

