Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268553AbUIGTzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268553AbUIGTzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268504AbUIGTyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:54:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:61826 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268590AbUIGTVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:21:47 -0400
Message-ID: <413E0A33.8090701@us.ibm.com>
Date: Tue, 07 Sep 2004 12:21:23 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org>
In-Reply-To: <20040904102914.B13149@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Sep 04, 2004 at 01:51:24AM +0100, Dave Airlie wrote:
> 
>>>Then drm_core would always be bundled with the OS.
>>>
>>>Is there any real advantage to spliting core/library and creating three
>>>interface compatibily problems?
>>
>>Yes we only have one binary interface, between the core and module, this
>>interface is minimal, so AGP won't go in it... *ALL* the core does is deal
>>with the addition/removal of modules, the idea being that the interface is
>>very minor and new features won't change it...
> 
> Umm, the Linux kernel isn't about minimizing interfaces.  We don't link a
> copy of scsi helpers into each scsi driver either, or libata into each sata
> driver.

Oh for crying out loud!  I have posted a clear, concise explaination of 
why THIS WILL NEVER HAPPEN at least 10 times.  Unless you are willing to 
take over all user support issues that this *WILL* create from now until 
the end of time on all DRI supported platforms, GO AWAY!  Your endless 
squaking is doing nothing be waste developer time.  For the DRI project, 
that is a very valuable commodity.

P.S.: Welcome to my spam filter.

