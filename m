Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVIHOjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVIHOjX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbVIHOjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:39:23 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:12366 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751370AbVIHOjX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:39:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZrJSftOLaoi+lyqxGyLm/TYdReYGqx/JYUw59M+bsfUP+Ecaw++uz8JFWqQR0n52TolSZ/QM9wJIxlXiIn90m55cuNDUQTZd5VDFs2Mh7T7/NeDqFxeyYC/bIOZ5hjh/Vn4Af37/Y6XSyMIa1EZ+TQGhH2dQwb785LtyksjCKK4=
Message-ID: <d120d500050908073942876de5@mail.gmail.com>
Date: Thu, 8 Sep 2005 09:38:46 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Christoph Litters <christophlitters@gmx.de>
Subject: Re: [DRIVER] Where is the PSX Gamepad Driver in 2.6.13-rc3?
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <43201906.8040902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42E48CA5.9010709@m1k.net> <43201906.8040902@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, Christoph Litters <christophlitters@gmx.de> wrote:
> Hello,
> 
> I have an adapter usb to psx i have tried it with 2.6.9 and it works
> perfectly with the kernel driver.
> with 2.6.12 i cant get it to work and with 2.6.13-rc3 i havent seen any
> option to enable it.
> could anybody help me?
> 

Device Drivers  ---> Input device support  ---> Joysticks  ---> 
Multisystem, NES, SNES, N64, PSX joysticks and gamepads

Needs parport support.

-- 
Dmitry
