Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbUCSR2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 12:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbUCSR2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 12:28:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62403 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263044AbUCSR20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 12:28:26 -0500
Message-ID: <405B2DAC.8030903@pobox.com>
Date: Fri, 19 Mar 2004 12:28:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Uwe Koziolek <uwe.koziolek@gmx.net>
CC: Zero10 <damouse@zero10.demon.co.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Fw: SiS 964 SerialATA developers anywhere?
References: <003001c40d3b$dd275330$2200a8c0@glowworm>	 <405A2B4A.9090001@pobox.com> <1079720801.3147.7.camel@uk2.local>
In-Reply-To: <1079720801.3147.7.camel@uk2.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Koziolek wrote:
> Hello,
> 
> i have found the problem (reset PCI_COMMAND_INTX_DISABLE), but the
> source must be cleaned, and some tests must be executed before i submit
> the source. 

Ah yes, that makes sense.


> Who will check in the source?.

I will, just email me the driver you have tested...

	Jeff



