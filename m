Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbTINWbn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 18:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbTINWbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 18:31:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6786 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262043AbTINWbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 18:31:40 -0400
Message-ID: <3F64EC3E.5040102@pobox.com>
Date: Sun, 14 Sep 2003 18:31:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugo Mills <hugo-lkml@carfax.org.uk>
CC: "J.A. Magallon" <jamagallon@able.es>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: libata update posted
References: <3F628DC7.3040308@pobox.com> <20030913211332.GC3478@werewolf.able.es> <20030913213828.GC21426@gtf.org> <20030914222736.GA29560@carfax.org.uk>
In-Reply-To: <20030914222736.GA29560@carfax.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugo Mills wrote:
> On Sat, Sep 13, 2003 at 05:38:28PM -0400, Jeff Garzik wrote:
> 
>>No user documentation, but feel free to ask me questions.  Here's a
>>quick overview:
>>
>>ata_piix, ata_via -- low-level driver modules
>>libata -- shared code module for the above
> 
> 
>    Do you have any plans to support SiI3112 in libata? The current
> SiI3112 drivers in the kernel just don't seem to work right on my
> hardware. :(


Yes!  It should be fairly quick to add Silicon Image SATA support, too.

It's all about finding the time to do it ;-)  Hopefully some time in the 
next week or two...

	Jeff



