Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVBOQTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVBOQTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 11:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVBOQTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 11:19:05 -0500
Received: from postman.ripe.net ([193.0.0.199]:33468 "EHLO postman.ripe.net")
	by vger.kernel.org with ESMTP id S261776AbVBOQOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:14:37 -0500
Message-ID: <42122016.80107@colitti.com>
Date: Tue, 15 Feb 2005 17:15:18 +0100
From: Lorenzo Colitti <lorenzo@colitti.com>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz>	 <200502150605.11683.s0348365@sms.ed.ac.uk>  <4211E729.1090305@colitti.com> <1108482083.12031.10.camel@elrond.flymine.org>
In-Reply-To: <1108482083.12031.10.camel@elrond.flymine.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-RIPE-Spam-Level: 
X-RIPE-Spam-Tests: ALL_TRUSTED,BAYES_00
X-RIPE-Spam-Status: N 0.004079 / -5.9
X-RIPE-Signature: f34c5deceb162d46cd2a27edf4b4d057
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
>>I beg to differ: it works for me on 2.6.11-rc3 (even with the swsusp2 
>>patch). However, I need to use acpi_sleep=s3_bios, and I can't use 
>>radeonfb or it will lock up on resume.
> 
> Could you grab dmidecode from http://www.nongnu.org/dmidecode/ and
> provide the output? It'd be interesting to compare working with
> non-working machines. It might also be good to see lspci and acpidmp
> output.

Ok, here is the output from dmidecode (Debian package) and from lspci. I 
don't have acpidmp and I don't know where to get it, but if you think 
it's necessary I can download it if you tell me where to find it.


Cheers,
Lorenzo
