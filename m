Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268070AbUJOPks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268070AbUJOPks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268049AbUJOPks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:40:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17882 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268080AbUJOPig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:38:36 -0400
Message-ID: <416FEEE5.4020603@pobox.com>
Date: Fri, 15 Oct 2004 11:38:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: "John W. Linville" <linville@tuxdriver.com>, Mark Lord <lsml@rtr.ca>,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: [PATCH] Export ata_scsi_simulate() for use by non-libata drivers
References: <416D8A4E.5030106@pobox.com> <416DA951.2090104@rtr.ca> <416DAF1A.2040204@pobox.com> <416DB912.7040805@rtr.ca> <416DBC96.2090602@pobox.com> <416EA996.4040402@rtr.ca> <416EAECC.7070000@rtr.ca> <416EB1B6.5070603@pobox.com> <416EC90A.30607@rtr.ca> <416F5A72.9080602@pobox.com> <20041015092535.C25937@tuxdriver.com> <416FE5E6.3000309@osdl.org>
In-Reply-To: <416FE5E6.3000309@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> John W. Linville wrote:
> 
>> On Fri, Oct 15, 2004 at 01:04:50AM -0400, Jeff Garzik wrote:
>>
>>> The full body of your email is pasted into the BitKeeper changeset 
>>> description.
>>
>>
>>
>> Jeff,
>>
>> Andrews "The perfect patch"
>> (http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt) in section
>> 3.e says:
>>    Most people's patch receiving scripts will treat a ^--- string
>>    as the separator between the changelog and the patch itself.  You can
>>    use this to ensure that any diffstat information is discarded when the
>>    patch is applied:
>>
>> Do your scripts act this way as well?
> 
> 
> Jeff, are your scripts available somewhere (for the rest of us)?


I use Linus's scripts, http://bktools.bkbits.net/

	Jeff


