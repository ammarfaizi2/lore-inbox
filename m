Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWCBMkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWCBMkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWCBMkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:40:45 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64439 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932262AbWCBMko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:40:44 -0500
Message-ID: <4406E7C2.7050904@pobox.com>
Date: Thu, 02 Mar 2006 07:40:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jens Axboe <axboe@suse.de>, Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia: add another ide-cs CF card id
References: <200603012259.k21MxBXC013582@hera.kernel.org>	 <44062FF1.4010108@pobox.com> <20060302075004.GA17789@isilmar.linta.de>	 <4406D44A.4020101@pobox.com>	 <1141299117.3206.37.camel@laptopd505.fenrus.org>	 <20060302114220.GH4329@suse.de>	 <1141301225.3206.50.camel@laptopd505.fenrus.org>	 <4406E1C7.7020908@pobox.com> <1141302442.3206.53.camel@laptopd505.fenrus.org>
In-Reply-To: <1141302442.3206.53.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>About a quarter of the time when non-netdev maintainers add IDs, through 
>>the magic of merges, we've wound up with duplicate IDs in the driver. 
>>I've snipped several duplicate IDs from tulip and other net drivers over 
>>the years.
> 
> 
> sure. But in this case Dominik IS the maintainer

Bus is far less relevant.  Should sbus and SoC bus patches skip 
subsystem peer review?  Of course not.  PCMCIA is not a special case here.


>>Further, in the past Brodo has _already_ been asked to CC relevant 
>>maintainers and lists -- or at least LKML -- with his patches.
> 
> 
> he mailed the relevant list, linux-pcmcia ... whats wrong?

linux-pcmcia is not the place to talk about IDE and net driver patches.

	Jeff


