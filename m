Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTJEVc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 17:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTJEVc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 17:32:57 -0400
Received: from mail.g-housing.de ([62.75.136.201]:50820 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263867AbTJEVc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 17:32:56 -0400
Message-ID: <3F8071E8.1050303@g-house.de>
Date: Sun, 05 Oct 2003 21:32:56 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030914 Thunderbird/0.3a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: compile error with 2.6.0-test6 on ppc32
References: <3F7EE203.4030601@g-house.de> <pan.2003.10.04.17.39.19.402587@smurf.noris.de>
In-Reply-To: <pan.2003.10.04.17.39.19.402587@smurf.noris.de>
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs wrote:
> Hi, Christian Kujau wrote:
> 
> 
>>upon compiling kernel 2.6.0-test6 on my PowerPC 604r machine (PReP),
>>i got the following error:
>>
> 
> That's a regression in binutils. Debian/unstable fixed it in version
> 2.14.90.0.6-3.

indeed! i just have to update *even more* often :-)

hm, the term "regression" is only known to me from mathematics, but i 
don't know how this could be related to compiling issues....

Thank you, 2.6.0-test6 is compiling now.
Christian.
-- 
BOFH excuse #88:

Boss' kid fucked up the machine


