Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267456AbUBSB74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUBSB74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:59:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52682 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267456AbUBSB7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:59:09 -0500
Message-ID: <4034185A.1020609@pobox.com>
Date: Wed, 18 Feb 2004 20:58:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: struct hdlc_device + embedded struct net_device disassosiation
References: <m3brnvn98c.fsf@defiant.pm.waw.pl>
In-Reply-To: <m3brnvn98c.fsf@defiant.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Hi,
> 
> Your 2.6 network patchkits contained patches disassociating struct
> net_device from struct hdlc_device in drivers/net/wan/hdlc_*
> and in various hw WAN drivers. What is the status of this patch?
> Is it still needed and while it was dropped as untested, should I
> review/test it? It looks quite complete and reasonable I think.

It was merged earlier today into 2.6.x mainline, and should appear in 
tonight 2.6.3-BK snapshot.

Any additional testing and review would certainly be appreciated!

	Jeff



