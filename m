Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266396AbTGEQ3S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 12:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbTGEQ3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 12:29:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266396AbTGEQ3P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 12:29:15 -0400
Message-ID: <3F070037.6080501@pobox.com>
Date: Sat, 05 Jul 2003 12:43:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: PATCH: Fix DMI missing string in -bk2 snapshot
References: <200307051609.h65G9Y88032402@hraefn.swansea.linux.org.uk>
In-Reply-To: <200307051609.h65G9Y88032402@hraefn.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> (Now Jeff has snapshots I can fix these things - thanks Jeff)


Note that I screwed up the version number on the Makefile, and so, I 
recreated the snapshots from scratch.

2.4.21-bk1 is out there, freshly generated... and it supercedes the 
previous 2.4.21-bk[12].  Apologies for any confusion, this should be a 
one-time thing.

	Jeff



