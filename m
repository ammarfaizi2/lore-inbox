Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTIOViF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTIOViE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:38:04 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:41900 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261605AbTIOViA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:38:00 -0400
Message-ID: <3F66310E.3000209@abcpages.com>
Date: Mon, 15 Sep 2003 23:37:18 +0200
From: Nicolae Mihalache <mache@abcpages.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test4 problems: suspend and touchpad
References: <Pine.LNX.4.33.0309150949270.950-100000@localhost.localdomain> <3F662322.9060205@abcpages.com>
In-Reply-To: <3F662322.9060205@abcpages.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolae Mihalache wrote:

> Patrick Mochel wrote:
>
>>
>> It does not. Could you please try removing the module before you 
>> suspend?
>
> Yes, removing and readding the module does the trick.
> Unfortunately I've seen that something else does not work after 
> resume: my USB mouse.
> But for some reason I can not remove the usbcore module, the kernel 
> says it's in use. 

I see that the mouse is not even powered. It's an optical mouse and the 
light stays switched off.

mache

