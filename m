Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269436AbRHGDFP>; Mon, 6 Aug 2001 23:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270044AbRHGDEz>; Mon, 6 Aug 2001 23:04:55 -0400
Received: from [211.100.84.134] ([211.100.84.134]:62990 "HELO linux.tcpip.cxm")
	by vger.kernel.org with SMTP id <S269436AbRHGDEs>;
	Mon, 6 Aug 2001 23:04:48 -0400
Date: Tue, 7 Aug 2001 11:04:51 +0800
From: hugang <linuxbest@soul.com.cn>
To: chen_xiangping@emc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems in using loadLin
Message-Id: <20010807110451.312b4ffd.linuxbest@soul.com.cn>
In-Reply-To: <20010807105559.32d36713.hugang@linux.tcpip.cxm>
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC549@elway.lss.emc.com>
	<20010807105559.32d36713.hugang@linux.tcpip.cxm>
Organization: soul
X-Mailer: Sylpheed version 0.5.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 6 Aug 2001 10:20:46 -0400 
> "chen, xiangping" <chen_xiangping@emc.com> wrote:
> 
> > Hi,
> > 
> > I am trying to use loadlin to boot up a machine. But after I 
> > replaced the bzImage, the kernel fails to boot up. It prints 
> > out error messages like:
> > 	...
> > 	VFS: Mounted root (ext2 filesystem) readonly
> > 	Freeing unused kernel memory : 96K freed
> > 	Warning: unable to open an initial console
> > 	Kernel panic: No init found. Try passing init= option to kernel.
> > 
> > The boot.bat file is:
> > 	loadlin.exe bzImage ro root=0x0821
> > 
> > Thanks,
> > 
> > Xiangping
> 
> 	I thinks this problem  that is root=0x821 is not real root partition.
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
