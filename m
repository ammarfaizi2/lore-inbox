Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbULQX7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbULQX7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbULQX7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:59:54 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:9713
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S262236AbULQX7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:59:41 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: ide-cd problem revisited - more brainpower needed
Date: Fri, 17 Dec 2004 23:59:39 +0000
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jens Axboe <axboe@suse.de>
References: <200412121334.55460.alan@chandlerfamily.org.uk> <200412140020.18114.alan@chandlerfamily.org.uk> <41C1B018.2090903@tmr.com>
In-Reply-To: <41C1B018.2090903@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412172359.40037.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 December 2004 15:56, Bill Davidsen wrote:

>
> Is it? Or did the firmware "upgrade" make it worse? Can you reflash back
> to the original firmware and see if 2.4 works correctly?

Unfortunately not - the version I 'upgraded' from was not on their web site, 
so I don't have a way back.

I was a thought that crossed my mind, although the detailed problem of 
multiple interrupts after apparently successfully completing the 0x3c command 
still occurred in exactly the same way and place when using 2.6.10-rc3.



-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
