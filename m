Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUCSI4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 03:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUCSI4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 03:56:31 -0500
Received: from main.gmane.org ([80.91.224.249]:12196 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261988AbUCSI4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 03:56:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: tun/tap device + sysfs ...
Date: Fri, 19 Mar 2004 09:56:27 +0100
Message-ID: <405AB5BB.4080609@upb.de>
References: <20040315091625.GB2084@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 194.246.46.15
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
In-Reply-To: <20040315091625.GB2084@bytesex.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> eskarina kraxel ~# ls /sys/class/misc 
> agpgart/  device-mapper/  hw_random/  mcelog/  net/tun/  nvram/  psaux/  rtc/
>                                                ^^^^^^^
> That looks very wrong ...

Yes, and various ideas and patches have already been mailed to the list.
I don't know if anybody took care of them.

