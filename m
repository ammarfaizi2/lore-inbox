Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277018AbRJDQWo>; Thu, 4 Oct 2001 12:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277103AbRJDQWe>; Thu, 4 Oct 2001 12:22:34 -0400
Received: from hera.cwi.nl ([192.16.191.8]:10632 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S277018AbRJDQW2>;
	Thu, 4 Oct 2001 12:22:28 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 4 Oct 2001 16:22:55 GMT
Message-Id: <200110041622.QAA24650@vlet.cwi.nl>
To: linux-lvm@sistina.com, wichert@cistron.nl
Subject: Re: [linux-lvm] Re: partition table read incorrectly
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[if you answer me, please do not remove my email address -
these are rather busy times, and I glance only very superficially
at linux-kernel]

> I deleted all partitions with fdisk so I expect none to be there.
> fdisk shows none, but the kernel does.

You should have looked with sfdisk :-)

But the conclusion is that nothing is wrong with the kernel,
but that some lvm utilities and fdisk could stand improvement.
I changed fdisk a little.

Andries
