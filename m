Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbTAWPxv>; Thu, 23 Jan 2003 10:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbTAWPxv>; Thu, 23 Jan 2003 10:53:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63119 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265368AbTAWPxu> convert rfc822-to-8bit; Thu, 23 Jan 2003 10:53:50 -0500
Date: Thu, 23 Jan 2003 11:04:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: User & <breno_silva@beta.bandnet.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Expand VM 
In-Reply-To: <20030123155627.M95099@beta.bandnet.com.br>
Message-ID: <Pine.LNX.3.95.1030123110049.32244A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, User & wrote:

> 
> Hi all
> 
> I have one idea , and this is about expand virtual memory on linux boxes 
> connected in LAN.
> Example: Linux A is processing come information , and need more memory , so 
> with this source , Linux A could access virtual memory on Linux B in LAN.
> But i don´t know how translate the virtual address between Linux A and B , to 
> have success in acess VM, or how to send all the process for Linux B to be 
> processed.
> 
> Any ideas ?
> 
> Thanks
> Breno

Use a swap-file on another machine on the LAN to extend your virtual
memory if you run out of local swap-file space.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


