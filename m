Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319265AbSIFRED>; Fri, 6 Sep 2002 13:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319267AbSIFRED>; Fri, 6 Sep 2002 13:04:03 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24768 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319265AbSIFREC>;
	Fri, 6 Sep 2002 13:04:02 -0400
Date: Fri, 06 Sep 2002 10:06:27 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: jeff@AmeriCom.com, linux-kernel@vger.kernel.org
Subject: Re: Linux SMP kernel bug with > 512M ram
Message-ID: <55628028.1031306786@[10.10.2.3]>
In-Reply-To: <20020906165516.17282.qmail@solo.americom.com>
References: <20020906165516.17282.qmail@solo.americom.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works fine for me with up to 32Gb of RAM. Can you try a vaguely
current kernel?

Martin.

--On Friday, September 06, 2002 4:55 PM +0000 jeff@AmeriCom.com wrote:

> 
> I've been having problems with a few of our servers and I can't seem to find this 
> problem mentioned anywhere else. All of the dual processor machines will not operate 
> with greater than 512 megs of ram with the newer SMP kernels (2.4.7-10enterprise #1 
> SMP). Two of the dual P3 1ghz machines crash after a few minutes, when the memory 
> usage gets high enough, I presume. The errors they spit out vary, but its only when 
> I go over 512megs of ram, and only on dual processor machines. I had a slightly 
> different problem when I tried to set it up on a dual p2 266 machine, when I go over 
> 512 megs there, the system takes an hour to boot up, and everything crawls from 
> there. I asked a friend of mine to try this newer kernel with his dual processor 
> server, and he says the same thing (when I go over 512, it crashes). Has anybody had 
> this problem? Is there a fix?
> 
> Regards,
> 
> Jeffrey Moss
> jeff@americom.com
> 
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


