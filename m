Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbVIJFjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVIJFjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 01:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVIJFjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 01:39:24 -0400
Received: from zorg.st.net.au ([203.16.233.9]:41898 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S932209AbVIJFjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 01:39:24 -0400
Message-ID: <4322719E.8080301@torque.net>
Date: Sat, 10 Sep 2005 15:39:42 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ltuikov@yahoo.com
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com>
In-Reply-To: <20050910024454.20602.qmail@web51613.mail.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> --- James Bottomley <James.Bottomley@SteelEye.com> wrote:
> 
> 
>>On Fri, 2005-09-09 at 15:40 -0400, Luben Tuikov wrote:
>>
>>>+/**
>>>+ * sas_do_lu_discovery -- Discover LUs of a SCSI device
>>>+ * @dev: pointer to a domain device of interest
>>
>>Aside from all the other problems,
> 
> 
> "Aside from all the other problems"?
> 
> WTF?
> 
> This is very rude James.  You have to _specific_ as opposed to
> spreading FUD like this.
<snip>

Well folks, there seems too much heat and not enough light
in this exchange.

Luben has released a very large patch and it will take a few
days to analyse. It will be interesting to see how the
developers and maintainers of other SAS HBAs respond.

Doug Gilbert
