Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbTJaOjV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 09:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTJaOjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 09:39:21 -0500
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:21498 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S263312AbTJaOjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 09:39:13 -0500
Message-ID: <3FA27567.6080705@cornell.edu>
Date: Fri, 31 Oct 2003 09:44:55 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Schlichter <thomas.schlichter@web.de>
CC: Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
References: <200310301601.55588.schlicht@uni-mannheim.de> <200310301848.19065.bzolnier@elka.pw.edu.pl> <20031031130041.GI7314@suse.de> <200310311411.59469.thomas.schlichter@web.de>
In-Reply-To: <200310311411.59469.thomas.schlichter@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter wrote:
> On Friday 31 October 2003 14:00, Jens Axboe wrote:
> 
>>It's probably via + tcq, that drive is known good with ide-tcq. At least
>>I've never seen problems with it.
> 
> 
> Maybe it is a problem with via + tcq... so, how to debug?
> 
> @Ivan: Did you also use a via chipset when reporting the problems mentioned in
> http://www.ussg.iu.edu/hypermail/linux/kernel/0307.2/1655.html ? Beacuse your 
> point 4) indeed looks very similar to my problems...
> 
>   Thomas


Yes - VIA chipset.

00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)


