Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268148AbUHQIZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268148AbUHQIZe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268170AbUHQIZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:25:33 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:21971 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S268148AbUHQIXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:23:18 -0400
Message-ID: <4121C392.6060109@shadowconnect.com>
Date: Tue, 17 Aug 2004 10:36:34 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Warren Togami <wtogami@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
References: <411F37CC.3020909@redhat.com> <20040816191508.428f1022.akpm@osdl.org>
In-Reply-To: <20040816191508.428f1022.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Andrew Morton wrote:
> Warren Togami <wtogami@redhat.com> wrote:
>>This is a request to please merge the I2O patches currently in Andrew 
>>Morton's -mm tree into the mainline kernel.  They resolve all known 
>>reported issues with I2O RAID devices.  If they can be included soon, it 
>>would be possible to implement and test direct installation before FC3 
>>Test2 freeze.
> We'll get it in when Linus returns.

Wowww, great news \:D/

>>Also because Markus would never ask himself, I nominate Markus Lidel as 
>>the "maintainer" of the 2.6 generic I2O layer.  He has put a tremendous 
>>amount of work into improving an otherwise neglected part of the kernel. 
> No problem with that, but we wouldn't want to go adding Markus to
> ./MAINTAINERS without his approval.

It would be a great honor for me to be the maintainer of the I2O subsystem.


Best regads,



Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
