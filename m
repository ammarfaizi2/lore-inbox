Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUCVMJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 07:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUCVMJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 07:09:12 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:8580 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261904AbUCVMJL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 07:09:11 -0500
Message-ID: <405ED755.2070301@stesmi.com>
Date: Mon, 22 Mar 2004 13:08:53 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Chris Wedgwood <cw@f00f.org>, Pascal Schmidt <der.eremit@email.de>,
       Frank Cusack <fcusack@fcusack.com>, linux-kernel@vger.kernel.org
Subject: Re: Does Linux sync(2) wait?
References: <1C8xa-5lk-5@gated-at.bofh.it> <E1B54ub-00004H-OC@localhost> <20040322005953.GA12237@dingdong.cryptoapps.com> <405E611D.10008@nortelnetworks.com>
In-Reply-To: <405E611D.10008@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

>>> No idea about NFS, but sync(1) does wait. When I push 500M out to my
>>> MO drive, the cp operation returns fairly quickly because I usually
>>> have more than 500M free memory. Then I run sync(1), which takes
>>> about 20 minutes before it returns.
>>>
>>
>> 20 minutes?!
> 
> 
> He did say it was a magneto-optical drive.

That's 400KiB/s you know - pretty slow.

// Stefan
