Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282819AbRLGJb3>; Fri, 7 Dec 2001 04:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285445AbRLGJbU>; Fri, 7 Dec 2001 04:31:20 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:12810 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282819AbRLGJbE>; Fri, 7 Dec 2001 04:31:04 -0500
Subject: Re: kernel: ldt allocation failed
From: James Davies <james_m_davies@yahoo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kiril Vidimce <vkire@pixar.com>, Dan Maas <dmaas@dcine.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16CH6i-00059b-00@the-village.bc.nu>
In-Reply-To: <E16CH6i-00059b-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 19:26:28 +1000
Message-Id: <1007717194.1342.1.camel@Lord>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nVidia kernel drivers are open source. You can get them from
ftp://ftp.nvidia.com/pub/drivers/english/XFree86_40/1.0-2313/NVIDIA_kernel-1.0-2313.tar.gz

the 0.9 serious of drivers were buggy and crashed a lot, earning them a
bad rep. But the 1.0 series are faster and more stable than their
windows counterparts- I havn't had one crash, even with a faulty card
that kills windows constantly. 


On Fri, 2001-12-07 at 19:15, Alan Cox wrote:
> > I don't see how one can magically tell that this is an NVIDIA problem. 
> 
> We don't know. But since we don't have their source and they have our
> source only they can tell you.
> 
> > in the kernel and I imagine that even if the NVIDIA drivers are 
> > triggering the problem, there are other modules/apps that can bring 
> > about the same behavior.
> 
> Possibly, but you'll have to ask Nvidia to debug it for you. If you can
> reproduce a bug by 
> 	-	removing the nvidia modules so they wont be loaded
> 	-	hard booting the machine
> 	-	triggering the bug without loading the nvidia drivers
> 
> then please report it. If not, its between you and nvidia.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

