Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276468AbRJIMCL>; Tue, 9 Oct 2001 08:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276666AbRJIMCC>; Tue, 9 Oct 2001 08:02:02 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:22793 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S276468AbRJIMBw>; Tue, 9 Oct 2001 08:01:52 -0400
Date: Tue, 9 Oct 2001 17:53:11 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane List <stephane.list@fr.alcove.com>
Subject: Re: Reg-network driver.
In-Reply-To: <20011009105731.A835@alcove-fr>
Message-ID: <Pine.LNX.4.10.10110091750390.11843-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi stephane,

 I have cscope installed to search source files.
I could not find "register_netdevice()" functionthrough it. I want to see
where it calls the driver initialisation.
Please help me out.

Thanks in advance,
Warm regards,
sathish.j
On Tue, 9 Oct 2001, Stephane List wrote:

> On Tue, Oct 09, 2001 at 02:35:37PM +0530, SATHISH.J wrote :
> > Hi all,
> > I am trying to learn network drivers. Trying to initialise the driver we
> > call "register_netdev()". This function in turn calls
> > "register_netdevice()". Please tell me where register_netdevice() is
> > defined. I want to see the code because the init function of the driver is
> > called from function only as I heard. Please tell me where
> > "register_netdevice()" and "unregister_netdevice()" are defined in the
> > code.
> > 
> You can see it with :
> 
> http://lxr.linux.no/ident?i=register_netdevice
> 
> 
> You can also install LXR on your own PC.
> 
> Stephane
> -- 
> Stephane LIST                     -- <stephane.list@fr.alcove.com>
> Alcove, liberating software       -- <http://www.alcove.com/>
> 

