Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265804AbSKFQNE>; Wed, 6 Nov 2002 11:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSKFQNE>; Wed, 6 Nov 2002 11:13:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62220 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265804AbSKFQLg>;
	Wed, 6 Nov 2002 11:11:36 -0500
Message-ID: <3DC940A6.4010506@pobox.com>
Date: Wed, 06 Nov 2002 11:17:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: xmb <xmb@kick.sytes.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: initramfs in 2.5.46 wont compile
References: <2147483647.1036601487@[192.168.1.2]> <3DC93C34.40201@pobox.com> <2147483647.1036602241@[192.168.1.2]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xmb wrote:
> -- Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> ppc arch support for initramfs needs to be added...
> 
> 
> oh... is there a way to disable the initramfs build in a safe way so i 
> can continue compiling the kernel without it


Nope, just hunt around the ppc mailing lists for a patch... I'm sure one 
will appear very soon, if it hasn't already been created.

	Jeff




