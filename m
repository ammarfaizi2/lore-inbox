Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314131AbSDVMGI>; Mon, 22 Apr 2002 08:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314136AbSDVMGH>; Mon, 22 Apr 2002 08:06:07 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:32275 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S314131AbSDVMGG>; Mon, 22 Apr 2002 08:06:06 -0400
Message-ID: <3CC3FCD2.2030008@loewe-komp.de>
Date: Mon, 22 Apr 2002 14:06:42 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Libor =?ISO-8859-1?Q?Van=ECk?= <libor@conet.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Adding snapshot capability to Linux
In-Reply-To: <3CC3ECD2.9000205@conet.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Libor Vanìk wrote:
> Hi,
> I'm going to start my dissertation work which is "Adding snapshop 
> capability to Linux kernel with copy-on-write support". My idea is add 
> it as another VFS - I know that there is some snapshot support in LVM 
> but it's working on "device-level" and I'd like/have to do it on fs level.
> 

This functionality already exists in LVM (logical volume manager).


