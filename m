Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSIJVYa>; Tue, 10 Sep 2002 17:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318144AbSIJVYa>; Tue, 10 Sep 2002 17:24:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19475 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318138AbSIJVY3>;
	Tue, 10 Sep 2002 17:24:29 -0400
Message-ID: <3D7E640B.3020300@mandrakesoft.com>
Date: Tue, 10 Sep 2002 17:28:43 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Mickeler <steve@neptune.ca>
CC: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Linux 2.4.20-pre6 tg3 compile errors
References: <Pine.LNX.4.44.0209101716300.17602-100000@triton.neptune.on.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Mickeler wrote:
> Compiling in tg3 support using the tg3.c and tg3.h from 2.4.20-pre6
> 
> distro: debian woody
> 
> gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
> gcc version 2.95.4 20011002 (Debian prerelease)


those are the NAPI functions and struct members.

did NAPI get removed from 2.4.x again??

