Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWEIMM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWEIMM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWEIMM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:12:58 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57543 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932394AbWEIMM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:12:58 -0400
Subject: Re: libata PATA patch update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Radloff <radsaq@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3b0ffc1f0605081029o604e5a3eu62f58b765a10bf65@mail.gmail.com>
References: <1147104400.3172.7.camel@localhost.localdomain>
	 <3b0ffc1f0605081029o604e5a3eu62f58b765a10bf65@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 May 2006 13:24:56 +0100
Message-Id: <1147177496.3172.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-08 at 13:29 -0400, Kevin Radloff wrote:
> On 5/8/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > I've posted a new patch versus 2.6.17-rc3 up at the usual location.
> 
> Thanks for the update. I'm still getting the same oops when inserting
> a CF card, though:

Different oops I think 8) I've fixed that one now although it may well
be that ide2 once I release it now oopses where it did before the PCMCIA
change rather than where it did this time.

Alan

