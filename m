Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbULFRWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbULFRWH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbULFRWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:22:06 -0500
Received: from fire.osdl.org ([65.172.181.4]:44982 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261573AbULFRTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:19:23 -0500
Message-ID: <41B48C9E.6030607@osdl.org>
Date: Mon, 06 Dec 2004 08:45:18 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: host name length
References: <40521AA6.7070308@redhat.com> <20041203160538.77a22864.rddunlap@osdl.org> <Pine.LNX.4.53.0412060934450.11891@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0412060934450.11891@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>| POSIX nowadays contains
>>|
>>|   _POSIX_HOST_NAME_MAX
>>| and
>>|   HOST_NAME_MAX
>>|
>>| for programs to use to learn about the maximum host name length which is
>>| allowed.  _POSIX_HOST_NAME_MAX is the standard-required minimum maximum
>>| and the value must be 256.
> 
> [...]
> 
> Please also consider the DNS FAQ. If a (DNS) hostname cannot be longer than X
> chars (I don't have the number handy ATM), HOST_NAME_MAX should not be any
> greater than X also.

Hi Jan,
Can you be more specific, please?  about (which) DNS FAQ.
I found several "DNS FAQ"s, but nothing specific about
DNS hostname lengths.

-- 
~Randy
