Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbTLBDFC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 22:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTLBDFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 22:05:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49368 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264291AbTLBDE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 22:04:59 -0500
Message-ID: <3FCC014A.7050109@pobox.com>
Date: Mon, 01 Dec 2003 22:04:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Blow <joeblow341@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise 20378 + 2.6.0-test10 + libata patch 1
References: <BAY7-F848IdgO3RQppH0000114d@hotmail.com>
In-Reply-To: <BAY7-F848IdgO3RQppH0000114d@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Blow wrote:
> 
>> From: Jeff Garzik <jgarzik@pobox.com>
>>
>> Nope, libata Promise driver only supports Serial ATA.
> 
> 
> Bummer.  Will it ever support PATA?

No plans.


> Is the Promise RAID support noticably faster than using md and a dumb 
> ATA/133 controller?

Using standard kernel drivers, Promise RAID _is_ md.

	Jeff



