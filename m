Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267977AbRHFLSn>; Mon, 6 Aug 2001 07:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267979AbRHFLSd>; Mon, 6 Aug 2001 07:18:33 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:62984 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267977AbRHFLSS>;
	Mon, 6 Aug 2001 07:18:18 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
cc: rich+ml@lclogic.com, linux-kernel@vger.kernel.org
Subject: Re: module unresolved symbols 
In-Reply-To: Your message of "Sun, 05 Aug 2001 12:06:50 -0400."
             <200108051606.f75G6onM009519@sleipnir.valparaiso.cl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Aug 2001 21:18:23 +1000
Message-ID: <3974.997096703@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Aug 2001 12:06:50 -0400, 
Horst von Brand <vonbrand@sleipnir.valparaiso.cl> wrote:
>Keith Owens <kaos@ocs.com.au> said:
>> Broken kernel makefiles when module symbols are turned on.
>> http://www.tux.org/lkml/#s8-8
>
>Or leftover modules from the stock install.

Not with kernel 2.4.  I changed make modules_install to erase the old
kernel modules precisely to avoid this problem.

