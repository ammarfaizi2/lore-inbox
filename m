Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266010AbUFDVUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266010AbUFDVUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 17:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUFDVUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 17:20:22 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:32674 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S266010AbUFDVUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 17:20:17 -0400
Message-ID: <40C0E66B.3020509@myrealbox.com>
Date: Fri, 04 Jun 2004 14:15:23 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-bk4: empty-named directory in /sys
References: <fa.damn9ec.1n4co3u@ifi.uio.no> <fa.nssco73.187q0r9@ifi.uio.no>
In-Reply-To: <fa.nssco73.187q0r9@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> On Friday 04 June 2004 23:26, Greg KH wrote:
> 
>>Hm, is the hostap code in the main kernel tree now?  That's the only
>>thing odd that I see from your messages.  Does this happen with
>>2.6.7-rc2 with no extra patches?

This happens in 2.6.7-rc1-mm1 too, both with and without hostap (I just 
tried it).

--Andy

