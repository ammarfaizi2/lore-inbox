Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269007AbUIQQD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269007AbUIQQD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269010AbUIQQCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:02:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64748 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269007AbUIQQAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 12:00:49 -0400
Message-ID: <414B0A24.1000609@pobox.com>
Date: Fri, 17 Sep 2004 12:00:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Florian Schirmer <jolt@tuxbox.org>, pp@ee.oulu.fi,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH][1/4] b44: Ignore carrier lost errors
References: <200408292218.00756.jolt@tuxbox.org>	<200408292233.03879.jolt@tuxbox.org>	<41324158.4020709@pobox.com>	<200408292304.25447.jolt@tuxbox.org> <20040829164528.220424e5.davem@davemloft.net>
In-Reply-To: <20040829164528.220424e5.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Sun, 29 Aug 2004 23:04:24 +0200
> Florian Schirmer <jolt@tuxbox.org> wrote:
> 
> 
>>Sorry for that. KMail seems to mangle the message as soon as you sign
>>it. Please find the non broken versions attached to this mail.
> 
> 
> I think Florian's changes are fine.
> 
> BTW, can someone fixup something for me?  Update MODULE_AUTHOR()
> please :-)  3/4 of this driver have been rewritten since I last
> touched it, heh.


done.

