Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262862AbSJWFD0>; Wed, 23 Oct 2002 01:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262865AbSJWFD0>; Wed, 23 Oct 2002 01:03:26 -0400
Received: from transport.cksoft.de ([62.111.66.27]:10769 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S262862AbSJWFDZ>; Wed, 23 Oct 2002 01:03:25 -0400
Date: Tue, 22 Oct 2002 21:04:17 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: Bongani <bhlope@mweb.co.za>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       <kraxel@bytesex.org>
Subject: Re: [Patch] 2.5.44 Stop bttv_driver.c from flooding /var/log/messages
In-Reply-To: <200210222202.22801.bhlope@mweb.co.za>
Message-ID: <Pine.BSF.4.44.0210222056330.717-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Bongani wrote:

Hi,

> Hi Alan
>
> I have sent this patch to Gerd and I did not get any reply from him, so...
> The bttv drivers are/were filling up my /var/log/messages file with the
> following output

I had sent a quite similar patch to Gerd and the v4l list (where I am
not subscribed) on Oct 6th. The only thing I got was the "maintainer
action required" reply from the list bot. As the archive is for
subsribers only I cannot say if it ever reached the list.

Alan please include this patch in -ac2.


To Suse-folks: what happend to gerd ? I had seen lots of questions
	regarding v4l2 on this list but no answers.

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

