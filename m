Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbUCTWik (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 17:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUCTWik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 17:38:40 -0500
Received: from mail.gmx.de ([213.165.64.20]:50334 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263558AbUCTWij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 17:38:39 -0500
X-Authenticated: #4512188
Message-ID: <405CC7EC.9030205@gmx.de>
Date: Sat, 20 Mar 2004 23:38:36 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
CC: Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5-rc2, hotplug and ohci-hcd issue
References: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org> <405C1B14.6000206@gmx.de> <20040320132334.GB13028@gemtek.lt> <405C979A.8070200@gmx.de>
In-Reply-To: <405C979A.8070200@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:

> I maybe found something: I compiled "force module unloading" into 
> kernel, and now it doesn't seem to hang, though I don't understand why 
> it should make a difference, as nothing is forced. I have to test a bit 
> more.

I was wrong, above doesn't work. It still hangs. I don't know how to 
circumvent it. Something seems to be broken.

Prakash
