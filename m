Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271283AbTHNXIz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 19:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271750AbTHNXIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 19:08:55 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:60548 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271283AbTHNXIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 19:08:54 -0400
Subject: Re: 2.6.0test3: scsi/net
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030814131936.GA7574@schottelius.org>
References: <20030814131936.GA7574@schottelius.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060902517.6641.21.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 15 Aug 2003 00:08:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-14 at 14:19, Nico Schottelius wrote:
> scsi:
>    why is 3ware ide controller still listed under the SCSI section?
>    other ide raids are under the ide menu, too.
>  
Because it acts as a SCSI device

>    should fusion mpt not be moved to the scsi section, too?
>    (as far as I understood mpt it looks like that...)

Its under messaging because its a messaging driver - its both scsi and
network for example


>  
