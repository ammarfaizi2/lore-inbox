Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbTDVMTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 08:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbTDVMTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 08:19:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53711 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263120AbTDVMTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 08:19:51 -0400
Message-ID: <3EA53625.8000805@pobox.com>
Date: Tue, 22 Apr 2003 08:31:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate CONFIG_TULIP_MWI
References: <Pine.GSO.4.21.0304171829030.10220-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0304171829030.10220-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> New bus configuration (EXPERIMENTAL)  
> CONFIG_TULIP_MWI
>   This configures your Tulip card specifically for the card and
>   system cache line size type you are using.
> 
>   This is experimental code, not yet tested on many boards.
> 
>   If unsure, say N.


This one, it matches the Config.in text and dependencies.

Good spotting,

	Jeff



