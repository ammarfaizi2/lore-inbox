Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269013AbUIQQD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269013AbUIQQD0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269007AbUIQQCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:02:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62956 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269006AbUIQQAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 12:00:39 -0400
Message-ID: <414B0A18.6020806@pobox.com>
Date: Fri, 17 Sep 2004 12:00:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Pietikainen <pp@ee.oulu.fi>
CC: Florian Schirmer <jolt@tuxbox.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH][1/4] b44: Ignore carrier lost errors
References: <200408292218.00756.jolt@tuxbox.org> <200408292233.03879.jolt@tuxbox.org> <41324158.4020709@pobox.com> <200408292304.25447.jolt@tuxbox.org> <20040829164528.220424e5.davem@davemloft.net> <20040829234928.GA10060@havoc.gtf.org> <20040830061020.GA21270@ee.oulu.fi>
In-Reply-To: <20040830061020.GA21270@ee.oulu.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Pietikainen wrote:
> On Sun, Aug 29, 2004 at 07:49:28PM -0400, Jeff Garzik wrote:
> 
>>>BTW, can someone fixup something for me?  Update MODULE_AUTHOR()
>>>please :-)  3/4 of this driver have been rewritten since I last
>>>touched it, heh.
>>
>>hehe.  I'll take care of it tonight when I queue Florian's stuff
>>to netdev-2.6 (and thus -mm, and thus eventually mainline).
> 
> And here's a resend of the bounce buffer patch, which should still
> apply on top of Florians (or without) just fine.
> 
> Signed-off-by: Pekka Pietikainen <pp@ee.oulu.fi>


patch applied to 2.6.x.

