Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTFCHDl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 03:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbTFCHDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 03:03:41 -0400
Received: from zimail1.unizh.ch ([130.60.128.11]:45506 "EHLO zimail1.unizh.ch")
	by vger.kernel.org with ESMTP id S262439AbTFCHDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 03:03:40 -0400
Message-ID: <3EDC4B72.7090407@hifo.unizh.ch>
Date: Tue, 03 Jun 2003 09:17:06 +0200
From: Marco Tedaldi <mtedaldi@hifo.unizh.ch>
Organization: Uni Zuerich
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: de-ch, de-de, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: siimage driver status
References: <Pine.LNX.4.44.0305291025550.11675-100000@bork.hampshire.edu> <1054216464.20725.70.camel@dhcp22.swansea.linux.org.uk> <001801c32631$642ba220$41010101@toshiba>
In-Reply-To: <001801c32631$642ba220$41010101@toshiba>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gutko wrote:
> From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>

> I have Asus A7N8X deluxe too, and I reported this issue with rc4.
> I'm running one IBM vancouver2 180gxp drive on SIL3112A, and I always have
> PIO on boot.
> I can enable DMA manually and it works good, but I can bet if I connect
> second hdd in RAID
> with this I already have, I'll get all problems described above!!! My friend
> also runs succesfully ONE
> hdd in DMA on the same ASUS on sata, but connecting seconf drive blows
> everything away..

This issue was reported by at least 3 People here on the list (including 
me) with different 21-rcX kernels. Seems noone really cared :-(

I hope, this issue now get's addressed.
btw. I could speed up my Transfer-Rate from 1.7MB/s to 55MB/s by setting
hdparm -d1 -X66 on my two native SATA-Drives.

bye

Marco

