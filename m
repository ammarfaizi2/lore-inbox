Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVANWKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVANWKs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVANWKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:10:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24273 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262197AbVANWJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:09:27 -0500
Message-ID: <41E84305.5070202@pobox.com>
Date: Fri, 14 Jan 2005 17:09:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Helten <andy.helten@dot21rts.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SATA hotplug status (sii3114)
References: <41E8292A.40302@dot21rts.com>
In-Reply-To: <41E8292A.40302@dot21rts.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Helten wrote:
> Hello,
> 
> Can anyone tell me the current status of hotplug support?  The SATA web 
> site says only this:
> 
>> libata does not support hotplug... yet. 
> 
> 
> 
> Is there a plan or design for adding hotplug support?  Can anyone point 
> me to any discussions on this matter.  I am new to Linux kernel 
> development, but I have searched the archives and found nothing very 
> helpful (except for the mention of the echo commands I tried below).  
> There could be a simple solution that is evading me, but I've looked for 
> two days now without much success.


There's a plan but no code yet.  :)

linux-ide@vger.kernel.org is where this stuff gets discussed (though 
there's nothing on there recently about hotplug).

	Jeff


