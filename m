Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030545AbVJGTqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030545AbVJGTqV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 15:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbVJGTqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 15:46:21 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:45582 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1030545AbVJGTqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 15:46:21 -0400
Message-ID: <4346D087.3020505@rainbow-software.org>
Date: Fri, 07 Oct 2005 21:46:15 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Sanchez <david.sanchez@lexbox.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Write file corruption - The next
References: <17AB476A04B7C842887E0EB1F268111E026FF7@xpserver.intra.lexbox.org>
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E026FF7@xpserver.intra.lexbox.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Sanchez wrote:
> Hi,
> 
> When I copy big file around (500MB) then sometimes the copied file
> differs from the source!
> 
> I try big copy on an AMD dbau1550 and on an EPIA Mini-ITX board using
> several Sata promise controllers (with DMA and without DMA) and using
> the IDE interface (with DMA and without DMA) and the problem still
> appears!!
> 
> More I try busybox 1.0 and 1.01 with kernel 2.4 to 2.6.13 and the
> problem still appears... memtest tool doesn't detect error...

Try GoldMemory - http://www.goldmemory.cz - it can sometimes detect a 
memory error that memtest can't.

-- 
Ondrej Zary
