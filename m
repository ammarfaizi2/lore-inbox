Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUE2Xzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUE2Xzq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 19:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUE2Xzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 19:55:46 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:57775 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261236AbUE2Xzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 19:55:45 -0400
Message-ID: <40B922EC.8060708@myrealbox.com>
Date: Sat, 29 May 2004 16:55:24 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Artemio <theman@artemio.net>, bcollins@debian.org,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] let IEEE1394 select NET
References: <200405291424.43982.theman@artemio.net> <20040529121408.GM16099@fs.tum.de> <20040529132356.A3014@flint.arm.linux.org.uk>
In-Reply-To: <20040529132356.A3014@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> On Sat, May 29, 2004 at 02:14:08PM +0200, Adrian Bunk wrote:
> 
>>The following patch lets FireWire support automatically select 
>>Networking support:
> 
> 
> And so we get another fscking symbol which has a non-obvious way to
> turn it off.
> 

Is it possible to make xconfig and menuconfig show what has an option selected?

--Andy
