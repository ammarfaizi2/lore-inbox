Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264918AbSKERB7>; Tue, 5 Nov 2002 12:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbSKERB7>; Tue, 5 Nov 2002 12:01:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16657 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264918AbSKERB6>;
	Tue, 5 Nov 2002 12:01:58 -0500
Message-ID: <3DC7FB11.10209@pobox.com>
Date: Tue, 05 Nov 2002 12:08:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
References: <20021105165024.GJ13587@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>Hi,
>
>Can it really be that one cannot edit a config file and run make
>oldconfig anymore? I'm used to editing an entry in .config and running
>oldconfig to fix things up, now it just reenables the option. That's
>clearly a major regression.
>  
>


It works fine for me :)

I don't think I could survive without the tried and true "vi .config ; 
make oldconfig" kernel configurator :)


