Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWH2KqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWH2KqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 06:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWH2KqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 06:46:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59577 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932253AbWH2KqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 06:46:14 -0400
Subject: Re: SDRAM or DDRAM in linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Niklaus <niklaus@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <85e0e3140608290004u94da11dr99c4dbcc0e417d7d@mail.gmail.com>
References: <85e0e3140608281040k61305f88m3f6cd4fcfddadaca@mail.gmail.com>
	 <85e0e3140608290004u94da11dr99c4dbcc0e417d7d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Aug 2006 12:08:16 +0100
Message-Id: <1156849696.6271.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-29 am 12:34 +0530, ysgrifennodd Niklaus:
> 1) How do i find out when the machine is online , if it is SDRAM or
> DDRAM. I tried dmidecode utility but i was not sure about the type.
> Can someone help me out by pasting the output for both DDR and SDRAM
> in dmidecode or similar.

Except for very high quality server boxes don't trust the dmidecode data
for the RAM. Get the motherboard/system name from dmidecode then look it
up manually


