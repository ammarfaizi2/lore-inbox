Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268674AbTGIWiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268673AbTGIWiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:38:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41350 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268644AbTGIWiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:38:08 -0400
Message-ID: <3F0C9CB3.8050802@pobox.com>
Date: Wed, 09 Jul 2003 18:52:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Fix IDE initialization when we don't probe for interrupts.
References: <Pine.LNX.4.44.0307091520570.16947-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0307091520570.16947-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

Thanks.


> (Obviously it must be zero for some architecture, though, or those
> conditionals woulnd't make sense. Alan?  Bartlomiej? What kind of sick
> pseudo-IDE controller doesn't have a control register?).

I asked Andre or Russell King or somebody this a while ago... IIRC it is 
some obscure ATARI IDE controller, or somesuch.

	Jeff



