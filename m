Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTH3BJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 21:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbTH3BJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 21:09:44 -0400
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:14564 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S262196AbTH3BJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 21:09:43 -0400
Message-ID: <3F4FFA2B.9030802@cornell.edu>
Date: Fri, 29 Aug 2003 21:13:15 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030816 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gaston Gransis <give54sh2@yahoo.com.ar>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via 8235 rear sound
References: <20030830003440.66145.qmail@web20714.mail.yahoo.com>
In-Reply-To: <20030830003440.66145.qmail@web20714.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gaston Gransis wrote:
> Hi everybody:
>   i came hear as the last resource ... i have tried
> with alsa mailing list, and nobody answered me ...
> I installed this driver(kernel 2.6.0-test2) and
> compiled all the alsa libraries.
> When i play sound everything works great except for
> the rear channel, and the center/lfe channel. 

I have the exact same problem with the exact same card.
Rear/center channels are dead unless I duplicate front.
Has been there since before the 2.6 series.

>  cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 0.9.4
> (Mon Jun 09 12:01:18 2003 UTC).
> Compiled on Aug 25 2003 for kernel 2.6.0-test2.

Verified with:

Advanced Linux Sound Architecture Driver Version 0.9.6 (Mon Jul 28 
11:08:42 2003 UTC).
Compiled on Aug 18 2003 for kernel 2.6.0-test3.

and alsa-lib 0.9.5




