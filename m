Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285442AbRLGJNh>; Fri, 7 Dec 2001 04:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285443AbRLGJN1>; Fri, 7 Dec 2001 04:13:27 -0500
Received: from pixar.pixar.com ([138.72.10.20]:7664 "EHLO pixar.pixar.com")
	by vger.kernel.org with ESMTP id <S285442AbRLGJNV>;
	Fri, 7 Dec 2001 04:13:21 -0500
Date: Fri, 7 Dec 2001 01:13:15 -0800 (PST)
From: Kiril Vidimce <vkire@pixar.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dan Maas <dmaas@dcine.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel: ldt allocation failed
In-Reply-To: <E16CH6i-00059b-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0112070108090.20196-100000@tombigbee.pixar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001, Alan Cox wrote:
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

Without turning this into a religous debate, is there any way to
find out what those messages really mean? When does one run into
an ldt allocation failure? What is ldt? I am not just trying to
solve this problem; I also want to understand what is going on
in the kernel.

Thanks for any explanations.

KV
--
  ___________________________________________________________________
  Studio Tools                                        vkire@pixar.com
  Pixar Animation Studios                        http://www.pixar.com/

