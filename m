Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268526AbTGIVum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 17:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268566AbTGIVum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 17:50:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64387 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268526AbTGIVul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 17:50:41 -0400
Message-ID: <3F0C9194.5060206@pobox.com>
Date: Wed, 09 Jul 2003 18:05:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Bas Mevissen <bas@basmevissen.nl>
CC: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: REQ: BCM4400 network driver for 2.4.22
References: <200307092333.36917.bas@basmevissen.nl>
In-Reply-To: <200307092333.36917.bas@basmevissen.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bas Mevissen wrote:
> Hi Linus, Alan, all,
> 
> Is the BCM4400 network driver planned for 2.4.22? It is in 2.4.22-pre3-ac1, 
> but not in 2.4.22-pre3.
> 
> As far as I can tell, it works fine. If needed, I can do some more testing.
> 
> I hope it can be included in the mainstream 2.4. It saves me (and a lot of 
> other people) the trouble of using an external driver.


b44 in 2.5 supports this, and it will be backported to 2.4.

Pekka Pietikainen just identified several bugs, so those will get fixed 
in the next day or so, then b44 will be sent to Marcelo.

	Jeff



