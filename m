Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262579AbTDAOyV>; Tue, 1 Apr 2003 09:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbTDAOyV>; Tue, 1 Apr 2003 09:54:21 -0500
Received: from [81.2.110.254] ([81.2.110.254]:15087 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S262579AbTDAOyU>;
	Tue, 1 Apr 2003 09:54:20 -0500
Subject: Re: Promise RAID controller card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Abhishek Sharma <abhisheks@dpsl.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <JKEIKAKAPLPIEBFPIFGGEELOCAAA.abhisheks@dpsl.net>
References: <JKEIKAKAPLPIEBFPIFGGEELOCAAA.abhisheks@dpsl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049206008.19702.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Apr 2003 15:06:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-02 at 03:52, Abhishek Sharma wrote:
> Can someone tell me if the RAID controller card from Promise SX6000 is
> supported by RHL 7.3 with kernel 2.4.18 ???

Some SX6000 setups work some don't. Promise also have their own driver
for the card you can download (its all source format). The older
supertrak100 also works but both of them seem rather slower than the
3ware cards

