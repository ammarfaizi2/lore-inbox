Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266303AbUGOTjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUGOTjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 15:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUGOTjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 15:39:47 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:12523 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S266303AbUGOTjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 15:39:45 -0400
Message-ID: <40F6DD54.5040308@zytor.com>
Date: Thu, 15 Jul 2004 12:39:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Schumacher <matt.s@aptalaska.net>
CC: Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       syslinux@zytor.com
Subject: Re: [syslinux] Re: Possible bug with kernel decompressor.
References: <40F490B6.6000106@schu.net> <40F5AE63.5010505@am.sony.com> <40F6C504.9010403@aptalaska.net>
In-Reply-To: <40F6C504.9010403@aptalaska.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Schumacher wrote:
> 
> I should note that this hardware requires the linux mem/memmap= params 
> because of the buggy memory detection in the bios so I was required to 
> use the uppermem command in grub to make it detect the memory and put 
> the initrd image in the right place.
> 

Specify, please.

	-hpa
