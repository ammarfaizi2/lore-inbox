Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267974AbUIXGaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267974AbUIXGaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268488AbUIXG1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:27:55 -0400
Received: from mail.convergence.de ([212.227.36.84]:30614 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S267974AbUIXGXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:23:54 -0400
Message-ID: <4153BD2A.8030407@linuxtv.org>
Date: Fri, 24 Sep 2004 08:22:34 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jean Delvare <khali@linux-fr.org>, sensors@Stimpy.netroedge.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Adding .class field to struct i2c_client (was Re: [PATCH][2.6]
 Add command function to struct i2c_adapter
References: <41500BED.8090607@linuxtv.org> <20040921115442.M18286@linux-fr.org> <415067CB.1020101@linuxtv.org> <20040924000202.GO14868@kroah.com>
In-Reply-To: <20040924000202.GO14868@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24.09.2004 02:02, Greg KH wrote:
> On Tue, Sep 21, 2004 at 07:41:31PM +0200, Michael Hunold wrote:
> 
>>Please have a look and tell me what you think. The big problem will be, 
>>that we cannot test all configurations, so it's possible that some 
>>devices won't be recognized anymore, because the .class entries don't match.

> I like the patches.  If you get them in a state you like (and drop the
> printk(), and use dev_dbg() instead), 

Ok.

> and send them 1 patch per file
> with the Signed-off-by: line, I'll be glad to apply them.

I'll re-create them against 2.6.9-rc2-mm2.

Do you really mean one patch per file, ie. about 50 separate patches? (I 
don't care, I simply write a script that splits them up)

> thanks,
> greg k-h

CU
Michael.

