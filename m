Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVCPSmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVCPSmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVCPSjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:39:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32965 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262734AbVCPSib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:38:31 -0500
Message-ID: <42387D1A.1030309@pobox.com>
Date: Wed, 16 Mar 2005 13:38:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.4
References: <20050316002222.GA30602@kroah.com> <m3u0nbybu8.fsf@defiant.localdomain> <20050316181644.GG20576@kroah.com>
In-Reply-To: <20050316181644.GG20576@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Mar 16, 2005 at 02:11:43PM +0100, Krzysztof Halasa wrote:
> 
>>Greg KH <greg@kroah.com> writes:
>>
>>
>>>I've release 2.6.11.4 with two security fixes in it.  It can be found at
>>>the normal kernel.org places.
>>
>>How about the N2/C101/PCI200SYN WAN driver fix (kernel panic on receive)?
>>
>>Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>
> 
> 
> It's queued up for the "normal" review process (will probably start
> tomorrow, or later today.)  This release was due to the ppp issue being
> public.

Krzysztof's patch is already ACK'd by me, FWIW (and its in upstream).

	Jeff



