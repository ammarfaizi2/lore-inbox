Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbUCVVY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbUCVVY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:24:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1426 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263136AbUCVVYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:24:25 -0500
Message-ID: <405F5978.40609@pobox.com>
Date: Mon, 22 Mar 2004 16:24:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Zehetbauer <thomasz@hostmaster.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 lockup with de4x5/de2104x driver
References: <1072119837.1383.11.camel@hostmaster.org>
In-Reply-To: <1072119837.1383.11.camel@hostmaster.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zehetbauer wrote:
> The de2104x driver primarily seems to fail receiving packets, running
> tcpdump I do only see arp-who-has packets beeing transmitted, after some
> time I do also get a 'eth0: timeout expired stopping DMA, kernel bug at
> drivers/net/tulip/de2104x.c:413!'


Does 2.6.5-rc2's de2104x driver work for you?

	Jeff



