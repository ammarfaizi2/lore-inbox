Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbTK3QqF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbTK3QqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:46:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25265 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264942AbTK3QqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:46:01 -0500
Message-ID: <3FCA1EBA.1070906@pobox.com>
Date: Sun, 30 Nov 2003 11:45:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Silicon Image 3112A SATA trouble
References: <Pine.LNX.4.44.0311291453550.838-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0311291453550.838-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
>>>So folks, try libata, as well.
>>
>>Thanks :)
> 
> 
> what do you think the chances are of libata becoming the primary ata
> interface for 2.4 and 2.6?  there have always been major changes even
> to stable releases in the past, at least when the change seems to be a 
> big improvement.

"primary ata interface" is a bit tough to define.  Serial ATA will 
become _the_ ATA interface on motherboards of the future.  From a 
software perspective, it really only matters what hardware driver you 
load...


> incidentally, can you give me any clues to description/discussion you
> might have engaged in about libata?  I saw your prog-ref pdf, but it 
> doesn't really describe the motivation, issues of going scsi, etc.
> (I looked at lkml and google, but couldn't filter well enough...)

Mostly just design in my head, plus a bit of discussion at the Kernel 
Summit earlier this year.


> feel free to reply to lkml.  libata design/status/future is clearly of 
> general interest...

I'm putting together a "Serial ATA status report", to be posted to lkml 
and linux-scsi, which should hopefully cover all that.  Your email kicks 
me into action again, for that report, for which I should thank you :)

	Jeff



