Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131658AbRAQJjg>; Wed, 17 Jan 2001 04:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131775AbRAQJj1>; Wed, 17 Jan 2001 04:39:27 -0500
Received: from [172.16.18.67] ([172.16.18.67]:39555 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131658AbRAQJjI>; Wed, 17 Jan 2001 04:39:08 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200101162111.f0GLBNb14141@webber.adilger.net> 
In-Reply-To: <200101162111.f0GLBNb14141@webber.adilger.net> 
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Bryan Henderson'" <hbryan@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Jan 2001 09:38:47 +0000
Message-ID: <20276.979724327@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


adilger@turbolinux.com said:
>  One reason why this may NOT ever make it into the kernel is that I
> know "kernel poking at devices" is really frowned upon. 

A possible alternative is to specify drives by serial number. 

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
