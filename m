Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTINRVO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 13:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTINRVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 13:21:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7400 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261216AbTINRVN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 13:21:13 -0400
Message-ID: <3F64A37A.1040803@pobox.com>
Date: Sun, 14 Sep 2003 13:20:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Cormack <justin@street-vision.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
References: <1063484193.1781.48.camel@mulgrave> 	<20030913212723.GA21426@gtf.org> <1063538182.1510.78.camel@lotte.street-vision.com>
In-Reply-To: <1063538182.1510.78.camel@lotte.street-vision.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Cormack wrote:
> LABEL= is so broken that I immediately remove it from all my redhat
> systems. It is not unique at all. As soon as you plug another system
> disk into your system at boot time all hell breaks loose.

That's your fault as a sysadmin ;-)

> At least it
> could have a random number in it or something.

You can use UUIDs today!  :)


> If you need to know your bootdisk (why?) why not just get the bootloader
> to tell you?

The only time one cares what the boot disk is, is when _installing_ the 
boot loader...

	Jeff



