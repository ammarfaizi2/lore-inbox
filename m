Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUDLVoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUDLVoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:44:14 -0400
Received: from ptb-relay01.plus.net ([212.159.14.212]:28172 "EHLO
	ptb-relay01.plus.net") by vger.kernel.org with ESMTP
	id S263019AbUDLVoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:44:10 -0400
Message-ID: <407B0E42.9060509@mauve.plus.com>
Date: Mon, 12 Apr 2004 22:46:42 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wolfgang Fritz <wolfgang.fritz@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Where did the USB generic scanner driver go? 2.6.5
References: <407AC3A1.8090503@mauve.plus.com> <c5ejt0$802$1@fritz38552.news.dfncis.de>
In-Reply-To: <c5ejt0$802$1@fritz38552.news.dfncis.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Fritz wrote:
> Ian Stirling wrote:
> 
>>I can't seem to find where this has moved.
>>Has it been obsoleted, or removed for some reason?
>>Many thanks.
>>Ian Stirling.
>>-
> 
> 
> This driver has been removed from the 2.6 kernel. You have to use libusb
> instead. I found the link below helpful:
> 
> http://khk.net/sane/libusb.html
> 
> Make sure you have a recent sane package installed.
> 

I've upgraded to the latest sane (the prereleases)

My scanner does not work, the backend manpage saying nothing about libusb,
suggesting it may not have been tested with it.

If the scanner module was deprecated, wouldn't some notice on the config
entry have been a good idea?
