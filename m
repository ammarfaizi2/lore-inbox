Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSEHDz4>; Tue, 7 May 2002 23:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315514AbSEHDzz>; Tue, 7 May 2002 23:55:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31237 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315513AbSEHDzz>;
	Tue, 7 May 2002 23:55:55 -0400
Message-ID: <3CD8A1A0.6080501@mandrakesoft.com>
Date: Tue, 07 May 2002 23:55:12 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI reorg changes for 2.5.14
In-Reply-To: <Pine.LNX.4.33.0205071433570.9905-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>The whole notion of having just _one_ PCI interrupt routing function is 
>definitely _broken_.
>

Yeah -- having a per-device interrupt router would be quite useful for 
those Via devices we had so much interrupt routing trouble with...

    Jeff




