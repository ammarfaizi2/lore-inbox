Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUIJPwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUIJPwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267535AbUIJPsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:48:33 -0400
Received: from pegasus.allegientsystems.com ([208.251.178.236]:14091 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S267519AbUIJPrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:47:53 -0400
Message-ID: <4141CCA8.30807@optonline.net>
Date: Fri, 10 Sep 2004 11:47:52 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: Latest microcode data from Intel.
References: <Pine.LNX.4.44.0409091726010.2713-100000@einstein.homenet> <4141CAAB.4020708@tmr.com>
In-Reply-To: <4141CAAB.4020708@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Why are you using /dev/cpu/microcode instead of /dev/cpu/N/microcode for 
> each CPU? Today they are all the same device, but for the future I would 
> think this was an obvious CYA.

Potentially stupid question, how does microcode update interact with CPU 
hotplug?

Nathan
