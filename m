Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266774AbTGKVEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266778AbTGKVEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:04:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15798 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266774AbTGKVD6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:03:58 -0400
Message-ID: <3F0F29A4.20408@pobox.com>
Date: Fri, 11 Jul 2003 17:18:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre5
References: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva>	<shsu19siyru.fsf@charged.uio.no>	<Pine.LNX.4.55L.0307111752060.5537@freak.distro.conectiva> <16143.10146.718830.585351@charged.uio.no>
In-Reply-To: <16143.10146.718830.585351@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>>>>>>" " == Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> 
> 
>     >> Is there still any chance for the NFS O_DIRECT support to make
>     >> it?
> 
>      > I guess the best way of doing so would be adding ->direct_io2
>      > and KERNEL24_HAS_ODIRECT_2 define.

IMO, yes.


> That is what the last patch I sent you does (also sent to l-k). Should
> I resend?

Sounds like it :)

Christoph, opinion?

	Jeff


