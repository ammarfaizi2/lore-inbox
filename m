Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264731AbUDWHKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbUDWHKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 03:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbUDWHKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 03:10:23 -0400
Received: from smtp.server-home.net ([195.137.212.50]:30737 "EHLO
	smtp.server-home.net") by vger.kernel.org with ESMTP
	id S264731AbUDWHKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 03:10:21 -0400
Message-ID: <4088C15E.3050504@domainbox.de>
Date: Fri, 23 Apr 2004 09:10:22 +0200
From: Jason Brian Friedrich <jf@domainbox.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.4.26] Booting from Adaptec PCI-X 133 29320 Rev C
References: <40865DFD.9000405@domainbox.de> <20040421162716.GE15950@logos.cnet>
In-Reply-To: <20040421162716.GE15950@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Apr 2004 07:13:24.0531 (UTC) FILETIME=[77884830:01C42902]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> On Wed, Apr 21, 2004 at 01:41:49PM +0200, Jason Brian Friedrich wrote:
> 
>> [problem booting from a "Adaptec PCI-X 133 29320 Rev C" with 2.4.26 but not with 2.4.25]

> Jason, can you please save the boot messages from both 2.4.25 and 2.4.26? 
 >
> Maybe you have a serial console around or at least you copy the relevant 
> parts (the card detection success with 2.4.25 and the card detection failure 
> with 2.4.26), plus the config files for both cases, and send us?
> 
> That would be helpful. There are no aic7xxx changes in 2.4.26. Are you using ACPI?

Hi Marcelo,

i will send you the boot messages from both kernels today as soon as 
possible. I think we have some serial consoles here so that it should 
be possible to give you the information about the card detection.
Should i send you the config files via email (also to the list?) or 
should i put them on a server so you can download them? I dont know 
which way you prefer. And yes, we are using ACPI.

So far,

Jason Brian Friedrich
