Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVHaWZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVHaWZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVHaWZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:25:27 -0400
Received: from terminus.zytor.com ([209.128.68.124]:47247 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964961AbVHaWZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:25:26 -0400
Message-ID: <43162E3A.9070703@zytor.com>
Date: Wed, 31 Aug 2005 15:24:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Chris Wedgwood <cw@f00f.org>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Andrew Morton <akpm@osdl.org>, SYSLINUX@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>	 <20050831215757.GA10804@taniwha.stupidest.org>	 <431628D5.1040709@zytor.com>	 <20050831220717.GA14625@taniwha.stupidest.org>	 <9a874849050831151230d68d64@mail.gmail.com>	 <20050831221424.GA14806@taniwha.stupidest.org> <9a8748490508311518320c6aba@mail.gmail.com>
In-Reply-To: <9a8748490508311518320c6aba@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> 
> Well, it wouldn't have to be initrd specifically. Generally what's
> needed is *some* way to tell the kernel "please read more options from
> location <foo>". The interresting bit is what <foo>'s supposed to be.
> 

This is what initramfs (as opposed to initrd) does quite well.

	-hpa

