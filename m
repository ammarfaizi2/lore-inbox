Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbTINL3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 07:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTINL3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 07:29:21 -0400
Received: from peabody.ximian.com ([141.154.95.10]:61130 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262399AbTINL3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 07:29:20 -0400
Message-ID: <3F6450D7.7020906@ximian.com>
Date: Sun, 14 Sep 2003 07:28:23 -0400
From: Kevin Breit <mrproper@ximian.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Need fixing of a rebooting system
References: <1063496544.3164.2.camel@localhost.localdomain> <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Sat, 13 Sep 2003, Kevin Breit wrote:
>
>  
>
>>Hey,
>>	I compiled 2.6.0-test5 today and installed it with a basic make
>>install.  This was a bz2 based kernel.  Unfortunately, just after the
>>kernel is uncompressed at bootup, the system reboots.  What can I do to
>>start fixing this?
>>    
>>
>
>Please verify your processor type in the configuration.
>  
>

I set the CPU type to PII/Celeron and recompiled.  It was at 
PIII/Celeron but it still won't work.  It is still rebooting.

Kevin

