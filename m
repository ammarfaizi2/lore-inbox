Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265892AbUFDRck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265892AbUFDRck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUFDRck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:32:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27265 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265833AbUFDRaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:30:09 -0400
Message-ID: <40C0B191.2040201@pobox.com>
Date: Fri, 04 Jun 2004 13:29:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
References: <1085689455.7831.8.camel@localhost> <200406041438.44706.bzolnier@elka.pw.edu.pl> <20040604124704.GA1946@suse.de> <200406041534.48688.bzolnier@elka.pw.edu.pl> <20040604152347.GD1946@suse.de>
In-Reply-To: <20040604152347.GD1946@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> else that works for barriers. It's mind boggling that nothing so far has
> come out of t13 to address this, I guess data integrity isn't high on
> their list.


Chuckle :)

Personally I look at it the other way around -- why hasn't anybody on 
the OS side written up a proposal that satisfies 100% of the OS barrier 
needs?

We've got the device manufacturer contacts these days to get serious 
attention paid, IMO.  Just need the proposal now.

Just like Linux, ATA evolves in the direction that people speak up 
about...  I'll leave it to the audience to decide if Windows and data 
integrity go hand-in-hand <grin>

	Jeff


