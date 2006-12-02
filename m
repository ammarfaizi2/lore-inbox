Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424259AbWLBR0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424259AbWLBR0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424252AbWLBR0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:26:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38296 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1424248AbWLBR0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:26:15 -0500
Date: Sat, 2 Dec 2006 17:31:07 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Nathanael Nerode <neroden@fastmail.fm>,
       Andres Salomon <dilinger@debian.org>
Subject: Re: RFC: removing the dgrs net driver
Message-ID: <20061202173107.47f609ca@localhost.localdomain>
In-Reply-To: <20061202171932.GP11084@stusta.de>
References: <20061202171932.GP11084@stusta.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006 18:19:32 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> Based on the information in the email forwarded below I'd remove the 
> dgrs net driver (this wasn't the first driver shipped with the kernel 
> without any hardware ever produced...).
> 
> Is this OK or is there any doubt whether this information is true?

As I understand it a small number of such devices were produced, but I
have no objection to it going away. Even if someone had such a card it
would not actually be useful any more.

Alan
