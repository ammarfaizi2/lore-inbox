Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265282AbUFAXYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUFAXYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 19:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbUFAXYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 19:24:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57486 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265282AbUFAXYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 19:24:49 -0400
Message-ID: <40BD1032.604@pobox.com>
Date: Tue, 01 Jun 2004 19:24:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael De Nil <michael@flex-it.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20378 Raid Accelerator
References: <Pine.LNX.4.56.0406012040380.6191@lisa.flex-it.be>
In-Reply-To: <Pine.LNX.4.56.0406012040380.6191@lisa.flex-it.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael De Nil wrote:
> Can someone tell me if I will be able to run 2 SATA discs on a raid1 with
> this chip, and if yes, what driver you would prefer? I am a litle bit
> afraid for using non-stable drivers... ;)


The all-open-source solution...  Linux "md" raid, and Linux SATA drivers :)

	Jeff


