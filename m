Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSE3Aot>; Wed, 29 May 2002 20:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSE3Aos>; Wed, 29 May 2002 20:44:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33285 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315941AbSE3Aos>;
	Wed, 29 May 2002 20:44:48 -0400
Message-ID: <3CF5758D.9080907@mandrakesoft.com>
Date: Wed, 29 May 2002 20:42:53 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: 2.5.19 - What's up with the kernel build?
In-Reply-To: <Pine.LNX.4.44.0205291947170.23147-100000@xanadu.home> <E17DDvk-0006qp-00@starship>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing I would like to see is building where builddir != srcdir.

I don't particularly care if this is optional or made a requirement, but 
it's darned useful...


