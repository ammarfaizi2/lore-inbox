Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311489AbSCNDJt>; Wed, 13 Mar 2002 22:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311490AbSCNDJi>; Wed, 13 Mar 2002 22:09:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1806 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311489AbSCNDJV>;
	Wed, 13 Mar 2002 22:09:21 -0500
Message-ID: <3C901455.5000704@mandrakesoft.com>
Date: Wed, 13 Mar 2002 22:09:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
In-Reply-To: <20020313185915.A14095@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tangential question, what's up with the prism2 driver?

It seems like everybody I meet these days has a wireless card which uses 
the prism2 driver from linux-wlan.org.  And since I just got two of 
these cards (D-Link DWL-650), I am strongly tempted to merge the driver 
into the kernel.

How well does the prism2 driver work with the current wireless driver API?
Is there any particular reason why it is not in the kernel now?

    Jeff




