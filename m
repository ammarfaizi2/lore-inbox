Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271971AbRIMSrH>; Thu, 13 Sep 2001 14:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271975AbRIMSqr>; Thu, 13 Sep 2001 14:46:47 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:41468 "EHLO
	postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S271971AbRIMSqf> convert rfc822-to-8bit; Thu, 13 Sep 2001 14:46:35 -0400
Date: Thu, 13 Sep 2001 11:32:18 -0700 (PDT)
From: "John D. Kim" <johnkim@aslab.com>
To: hugang <linuxbest@soul.com.cn>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <gero@gkminix.han.de>,
        <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: A patch for dhcp and nfsroot.
In-Reply-To: <20010829081411.753c1d1b.linuxbest@soul.com.cn>
Message-ID: <Pine.LNX.4.31.0109131131200.18725-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone tried this yet?  I've tried it on 2.4.9-ac8, but the module
complains of not being able find the kernel it was built for.

On Wed, 29 Aug 2001, hugang wrote:

> Alan Cox:
> 	Hello.
>
> 	This is my first kernel patch . It change the kernel dhcp auto config to module. So we can dynamic insmod the net card before insmod dhcp .This is useful to disaster recover linux.
>
> --
> Best Regard!
> 礼！
> ----------------------------------------------------
> hugang : 胡刚 	GNU/Linux User
> email  : gang_hu@soul.com.cn linuxbest@soul.com.cn
> Tel    : +861068425741/2/3/4
> Web    : http://www.soul.com.cn
>
> 	Beijing Soul technology Co.Ltd.
> 	   北京众志和达科技有限公司
> ----------------------------------------------------
>

