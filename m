Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbUCPUC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUCPUC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:02:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:232 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261496AbUCPUCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:02:50 -0500
Message-ID: <40575D5C.9000908@pobox.com>
Date: Tue, 16 Mar 2004 15:02:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: greg@kroah.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, bos@serpentine.com,
       linux-raid@vger.kernel.org
Subject: Re: [PATCH] klibc update
References: <4056B0DB.9020008@pobox.com>	<20040316005229.53e08c0c.akpm@osdl.org>	<20040316153719.GA13723@kroah.com>	<20040316111026.6729e153.akpm@osdl.org>	<40575279.7040408@pobox.com>	<20040316192458.GB21172@kroah.com>	<40575631.1080006@pobox.com> <20040316115340.361f2a14.akpm@osdl.org>
In-Reply-To: <20040316115340.361f2a14.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> >>Note that it isn't my intention to become klibc maintainer...  just in 
>> >>case anybody started getting ideas... :)
>> > 
>> > 
>> > I thought hpa was the klibc maintainer, you're just offering a patch to
>> > add it to the build :)
>>
>> Right...  I meant I am not going to become the maintainer of said 
>> patch/BK tree :)
> 
> 
> It would be rather handy if someone could maintain the definitive tree for
> this work for a while, until we linusify it.

Last I heard from LT direction was "OK but nothing uses it"


> I don't have a feeling for its stability/readiness/desirability/anthingelse
> at this stage.  How mergeable is it?

It still needs some testing before merging, and IMO still needs to 
resolve Linus's objection before it moves beyond the "big hunk of code 
that doesn't do much" stage.

It's IMO a 2.7 change...

	Jeff



