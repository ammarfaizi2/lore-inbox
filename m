Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbTHVGK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 02:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbTHVGK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 02:10:59 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:4361 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263029AbTHVGK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 02:10:57 -0400
Date: Fri, 22 Aug 2003 03:10:12 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       marcelo@conectiva.com.br
Subject: Re: [PATCH] 2/10 2.4.22-rc2 fix __FUNCTION__ warnings
 drivers/hotplug
Message-Id: <20030822031012.0036b2ce.vmlinuz386@yahoo.com.ar>
In-Reply-To: <20030822052000.GA7589@kroah.com>
References: <20030821012932.7179f30c.vmlinuz386@yahoo.com.ar>
	<20030822052000.GA7589@kroah.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003 22:20:00 -0700, Greg KH wrote:
>On Thu, Aug 21, 2003 at 01:29:32AM -0300, Gerardo Exequiel Pozzi wrote:
>>  cpqphp.h           |    6 ++--
>>  cpqphp_core.c      |   30 +++++++++++------------
>>  cpqphp_ctrl.c      |   68 ++++++++++++++++++++++++++---------------------------
>>  cpqphp_nvram.c     |    2 -
>>  cpqphp_pci.c       |   12 ++++-----
>>  pci_hotplug_core.c |    2 -
>>  pci_hotplug_util.c |    2 -
>>  7 files changed, 61 insertions(+), 61 deletions(-)
>> 
>> http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.hotplug.patch
>> http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.hotplug.patch.asc
>
>$ wget http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.hotplug.patch
>--22:18:07--  http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.hotplug.patch
>           => `drivers.hotplug.patch'
>Resolving www.vmlinuz.com.ar... done.
>Connecting to www.vmlinuz.com.ar[65.200.24.183]:80... connected.
>HTTP request sent, awaiting response... 404 Not Found
>22:18:36 ERROR 404: Not Found.

That strange the IP is 200.32.4.71 and not 65.200.24.183 (similar in your mail headers).

dns problem ?


>
>
>
>Please send send patches inline in email messages to the maintainers of
>the code that you are modifying, like Documentation/SubmittingPatches
>says to.


OK, sorry :(, in few minutes resending all the patches inline,
CC to the respective mantainers, and split in three parts one that is 90kb.


>
>thanks,
>
>greg k-h
>-


Take Care,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
