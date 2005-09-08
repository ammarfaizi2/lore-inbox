Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbVIHOmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbVIHOmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVIHOmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:42:36 -0400
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:3766 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S1751374AbVIHOmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:42:36 -0400
Message-ID: <43204DD4.3090103@lifl.fr>
Date: Thu, 08 Sep 2005 16:42:28 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.6-5mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Christoph Litters <christophlitters@gmx.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER] Where is the PSX Gamepad Driver in 2.6.13-rc3?
References: <42E48CA5.9010709@m1k.net> <43201906.8040902@gmx.de> <d120d500050908073942876de5@mail.gmail.com>
In-Reply-To: <d120d500050908073942876de5@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

09/08/2005 04:38 PM, Dmitry Torokhov wrote/a écrit:
> On 9/8/05, Christoph Litters <christophlitters@gmx.de> wrote:
> 
>>Hello,
>>
>>I have an adapter usb to psx i have tried it with 2.6.9 and it works
>>perfectly with the kernel driver.
>>with 2.6.12 i cant get it to work and with 2.6.13-rc3 i havent seen any
>>option to enable it.
>>could anybody help me?
>>
> 
> 
> Device Drivers  ---> Input device support  ---> Joysticks  ---> 
> Multisystem, NES, SNES, N64, PSX joysticks and gamepads
> 
> Needs parport support.
> 

Are you sure? Isn't this only for parallel to psx adapters? Christoph 
says he has a "usb to psx" adapter.

Eric
