Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbUBZDJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUBZDJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:09:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20434 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262618AbUBZDJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:09:42 -0500
Message-ID: <403D6368.70802@pobox.com>
Date: Wed, 25 Feb 2004 22:09:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) status report
References: <403D5B3D.6060804@pobox.com> <403D5FE1.1070203@matchmail.com>
In-Reply-To: <403D5FE1.1070203@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> Jeff Garzik wrote:
> 
>> VIA
>> ---
>> Summary:  No TCQ.  Looks like a PATA controller, but with full SATA
>> control including hotplug and PM.
>>
>> libata driver status:  Beta.
> 
> 
> Does drivers/ide support this also?


Yes.  Glad you mentioned that...

	Jeff



