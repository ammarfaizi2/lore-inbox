Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbTLaGhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 01:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbTLaGhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 01:37:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4548 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266139AbTLaGhR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 01:37:17 -0500
Message-ID: <3FF26E8A.5070806@pobox.com>
Date: Wed, 31 Dec 2003 01:36:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Karel_Kulhav=FD?= <clock@twibright.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compatibility of Nvidia NVNET driver license with GPL
References: <20031231073101.A474@beton.cybernet.src>
In-Reply-To: <20031231073101.A474@beton.cybernet.src>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavý wrote:
> Hello
> 
> I faintly remember reading some article on the Net from Linus Torvalds stating
> something like if a piece of code is written specifically for Linux kernel, it
> must be under GPL.
> 
> I have got an nVidia NForce2 board and downloaded their Ethernet driver (nvnet)
> and they say in README: "the network driver provided by NVIDIA is subject to
> the NVIDIA software license". How is with compatibility of such a behaviour
> with GPL of the kernel sources?


Since I am not a lawyer, my engineering suggestion would be to sidestep 
legal issues by using "forcedeth" driver, to drive your nForce NIC. 
It's fully GPL'd, and full open source.

	Jeff



