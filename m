Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbTIAQNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbTIAQNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:13:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64166 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263003AbTIAQNB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:13:01 -0400
Message-ID: <3F537001.7070304@pobox.com>
Date: Mon, 01 Sep 2003 12:12:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       tigran@aivazian.fsnet.co.uk
Subject: Re: dontdiff for 2.6.0-test4
References: <Pine.GSO.4.44.0309010848040.18476-100000@north.veritas.com>
In-Reply-To: <Pine.GSO.4.44.0309010848040.18476-100000@north.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
>>On Mon, Sep 01, 2003 at 07:57:27AM -0700, Tigran Aivazian wrote:
>>
>>>I have updated dontdiff in the usual place:
>>>
>>>  http://www.moses.uklinux.net/patches/dontdiff
>>>
>>>for the 2.6 kernels. Obviously this was only tested on my configuration(s)
>>>so any additions are welcome. Just email them to me and I will add them.
>>>
>>>For those who don't know what "dontdiff" is --- grep the file:
>>>
>>>/usr/src/linux/Documentation/SubmittingPatches
>>
>>Btw, what about putting this somewhere in the kernel tree?
> 
> 
> Probably a good idea, because I hesitated whether to call this
> "dontdiff-2.6" and leave the existing dontdiff for 2.4 or just switch to
> 2.6 (assuming it is applicable to 2.4 as well). But if it is in the kernel
> tree then no need to worry about which dontdiff matches which kernel.


I'll throw it into 2.6.  I use dontdiff all the time :)

FWIW I use the same dontdiff for 2.4 and 2.6...

	Jeff


