Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbUJ1E0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbUJ1E0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 00:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbUJ1E0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 00:26:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14744 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262753AbUJ1E0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 00:26:34 -0400
Message-ID: <418074EC.7080405@pobox.com>
Date: Thu, 28 Oct 2004 00:26:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Willy Tarreau <willy@w.ods.org>,
       "David M. Wilson" <dw_lkml@botanicus.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.28-rc1
References: <417E5904.9030107@ttnet.net.tr> <20041026203334.GB29688@logos.cnet>
In-Reply-To: <20041026203334.GB29688@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>>- David M. Wilson: sis900 Wake-on-LAN support
>>  http://marc.theaimsgroup.com/?l=linux-kernel&m=105835662823748&w=2
> 
> 
> Jeff?

Two principal objections:

1) 2.6 first

2) should use the already-present ethtool WOL interface rather than 
inventing your own


>>- Willy Tarreau: MTU fix for tulip driver
>>  http://marc.theaimsgroup.com/?l=linux-kernel&m=109130863303540&w=2
> 
> 
> Jeff?

Looks OK but I would prefer at least a 2.6 version in parallel...

	Jeff


