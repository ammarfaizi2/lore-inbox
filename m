Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUK1TJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUK1TJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 14:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbUK1TJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 14:09:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261580AbUK1THZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 14:07:25 -0500
Message-ID: <41AA21D3.5050205@pobox.com>
Date: Sun, 28 Nov 2004 14:06:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "John W. Linville" <linville@tuxdriver.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: [patch 2.6.10-rc2] 3c59x: reload EEPROM values at rmmod for	needy
 cards
References: <20041117160122.A4824@tuxdriver.com>	 <20041117134425.62034944.akpm@osdl.org>	 <20041118012155.GA22765@tuxdriver.com> <1101663389.16787.46.camel@localhost.localdomain>
In-Reply-To: <1101663389.16787.46.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2004-11-18 at 01:21, John W. Linville wrote:
> 
>>On Wed, Nov 17, 2004 at 01:44:25PM -0800, Andrew Morton wrote:
>>
>>>This has been in -mm kernels since you first sent it out.  I'm intending to
>>>hold off until post-2.6.10 so we get a full kernel cycle for any problems
>>>to get shaken out.
>>
>>Cool...someone was asking for it in netdev-2.[46], and Jeff didn't
>>have it.  That is what provoked the resend.
> 
> 
> Merged into -ac since you essentially can't use 3c59x/3c90x with DHCP on
> some systems or get it back from suspend with several distributions.
> This IMHO should go into 2.6.10 because its a showstopper for many
> users. 

Poke Andrew to push it upstream, he's the 3c59x maintainer.

	Jeff



