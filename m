Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263554AbTIHUOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263569AbTIHUOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:14:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:34012 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263554AbTIHUOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:14:17 -0400
Date: Mon, 8 Sep 2003 13:11:31 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Mathieu LESNIAK <maverick@eskuel.net>
cc: <linux-kernel@vger.kernel.org>, <pavel@ucw.cz>
Subject: Re: Fs corruption with swsusp in test4-mm6 ?
In-Reply-To: <3F5CE25A.4020003@eskuel.net>
Message-ID: <Pine.LNX.4.33.0309081310040.972-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I haven't tested previous -test4-mm patches before this one, so I 
> couldn't tell you :(
> In addition, as I said to Pavel in private mail, this laptop is not 
> mine, and I won't be able to execute more tests on it.

Ah. I'm sorry to hear that. Thanks for testing anyway. 

If someone has tested suspend-to-disk while using reiserfs, I would be 
very interested to hear if they have or have not had success.. (For the 
record, I use ext3 and have not seen any comparable problems).

Thanks,


	Pat

