Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVIGStX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVIGStX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVIGStX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:49:23 -0400
Received: from relay02.infobox.ru ([195.208.235.29]:42987 "EHLO
	relay02.infobox.ru") by vger.kernel.org with ESMTP id S1750768AbVIGStW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:49:22 -0400
Message-ID: <431F35D2.7040209@vlnb.net>
Date: Wed, 07 Sep 2005 22:47:46 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: boutcher@cs.umn.edu, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Santiago Leon <santil@us.ibm.com>,
       Linda Xie <lxiep@us.ibm.com>
Subject: Re: [RFC] SCSI target for IBM Power5 LPAR
References: <20050906212801.GB14057@cs.umn.edu> <20050907104932.GA14200@lst.de> <20050907124504.GA13614@cs.umn.edu>
In-Reply-To: <20050907124504.GA13614@cs.umn.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave C Boutcher wrote:
> On Wed, Sep 07, 2005 at 12:49:32PM +0200, Christoph Hellwig wrote:
> 
>>On Tue, Sep 06, 2005 at 04:28:01PM -0500, Dave C Boutcher wrote:
>>
>>>This device driver provides the SCSI target side of the "virtual
>>>SCSI" on IBM Power5 systems.  The initiator side has been in mainline
>>>for a while now (drivers/scsi/ibmvscsi/ibmvscsi.c.)  Targets already
>>>exist for AIX and OS/400.
>>
>>Please try to integrate that with the generic scsi target framework at
>>http://developer.berlios.de/projects/stgt/.
> 
> 
> There hasn't been a lot of forward progress on stgt in over a year, and
> there were some issues (lack of scatterlist support, synchronous and
> serial command execution) that were an issue when last I looked.
> 
> Vlad, can you comment on the state of stgt and whether you see it
> being ready for mainline any time soon?

Sorry, I can see on stgt page only mail lists archive and not from start 
(from Aug 22). Mike, can I see stgt code and some design description, 
please? You can send it directly on my e-mail address, if necessary.

Vlad


