Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVDFJbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVDFJbS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 05:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVDFJbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 05:31:18 -0400
Received: from mail.customers.edis.at ([62.99.242.131]:15323 "EHLO
	smtp-1.edis.at") by vger.kernel.org with ESMTP id S262151AbVDFJbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 05:31:15 -0400
Message-ID: <4253AC67.7040803@lawatsch.at>
Date: Wed, 06 Apr 2005 11:31:19 +0200
From: Philip Lawatsch <philip@lawatsch.at>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: AMD64 Machine hardlocks when using memset
References: <3Ojst-4kX-19@gated-at.bofh.it> <3PxjH-812-3@gated-at.bofh.it> <42535FFF.4080503@shaw.ca> <200504060902.12066.rjw@sisk.pl>
In-Reply-To: <200504060902.12066.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:

>>Anyone have any suggestions on how to track this further? It seems 
>>fairly clear what circumstances are causing it, but as for figuring out 
>>what's at fault..
> 
> 
> Well, I would start from changing memory modules.

As I wrote earlier, I tried 4 different (but same brand) modules, 2
Infineon and 2 Samsung ones. No difference.

Btw, I've been working (stressing) the machine for one week now and
never had any problems, the system seems rock solid (until I start my
memory stresser).

kind regards Philip
