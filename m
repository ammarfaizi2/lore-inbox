Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278287AbRJSDjx>; Thu, 18 Oct 2001 23:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278289AbRJSDjn>; Thu, 18 Oct 2001 23:39:43 -0400
Received: from web15005.mail.bjs.yahoo.com ([61.135.128.8]:54792 "HELO
	web15005.mail.bjs.yahoo.com") by vger.kernel.org with SMTP
	id <S278287AbRJSDj2>; Thu, 18 Oct 2001 23:39:28 -0400
Message-ID: <20011019033955.43057.qmail@web15005.mail.bjs.yahoo.com>
Date: Fri, 19 Oct 2001 11:39:55 +0800 (CST)
From: =?gb2312?q?hanhbkernel?= <hanhbkernel@yahoo.com.cn>
Subject: Re: initrd problem of 2.4.10
To: markv@wave.co.nz
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011019141926.B596@mail.wave.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Mark van Walraven <markv@wave.co.nz> 的正文：> 
> On Fri, Oct 12, 2001 at 01:24:53PM +0800,
> hanhbkernel wrote:
> > There is no problem using the initial RAM disk
> > (initrd) with kernel 2.4.9
> > But with kernel 2.4.10 system reports the
> following
> > messages:
> > 
> > RAMDISK: compressed image found at block 0
> > Freeing initrd memory: 1153k freed
> > VFS: Mounted root (ext2 filesystem)
> > Freeing unused kernel (memory: 224k freed)
> > Kernel panic: No init found. Try passing
> init=option
> > to kernel
> 
> Check that /lib/ld-* in the initrd has execute
> permission.
> 
> Regards,
> 
> Mark.
thanks for your help but I have checked /lib/ld-* in
the initrd.the permission is right.please give me more
help 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

_________________________________________________________
Do You Yahoo!? 登录免费雅虎电邮! http://mail.yahoo.com.cn

<font color=#6666FF>无聊？郁闷？高兴？没理由？都来聊天吧！</font>—— 
雅虎全新聊天室! http://cn.chat.yahoo.com/c/roomlist.html
