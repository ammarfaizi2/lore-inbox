Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314411AbSDRSpj>; Thu, 18 Apr 2002 14:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314412AbSDRSpj>; Thu, 18 Apr 2002 14:45:39 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:32260 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S314411AbSDRSpi> convert rfc822-to-8bit; Thu, 18 Apr 2002 14:45:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Andrea Aime <aaime@libero.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre6+preempt problem...
Date: Thu, 18 Apr 2002 20:45:26 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <200204181426.30823.aaime@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204182045.26760.linux-kernel@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Aime wrote:
>while exiting from X windows yesterday I got the following error (the system 
[...]
> EIP:    0010:[<c0131c90>]    Tainted: P
[...]
> so far... (btw, I'm using NVidia latest drivers, compiled the kernel on a

And NVIDIA is the reason why propably nobody here can really help you. We 
don't have the source we don't know what the NVIDIA-module is doing.

Pipe your BUG through ksymoops and send the report to NVIDIA.

greetings

Christian


