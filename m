Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbUCOTOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUCOTOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:14:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61599 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262727AbUCOTOl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:14:41 -0500
Message-ID: <40560094.2040800@pobox.com>
Date: Mon, 15 Mar 2004 14:14:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Julien Didron <jdidron@tripnotik.dyndns.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH try3] a better Silicon Image SATA mod15 write fix?
References: <4055D032.1090708@pobox.com> <4055EF4F.8060803@pobox.com> <4055F045.40102@pobox.com> <40560C0E.7060500@tripnotik.dyndns.org>
In-Reply-To: <40560C0E.7060500@tripnotik.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Didron wrote:
> Hello list,
> 
>    This driver works :o)
>    running hdparm gives those results :
>    Timing buffered disk reads:  170 MB in  3.00 seconds =  56.60 MB/sec 
> (with 2.6.4-bk4 and sata_sil.c try 3)
>    Timing buffered disk reads:  170 MB in  3.01 seconds =  56.56 MB/sec 
> (with 2.6.4-mm2)

Thanks much for testing.  Try3 had a nasty bug, though.

Can you test Try4 as well?

Regards and thanks again,

	Jeff



