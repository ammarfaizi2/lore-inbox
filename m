Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264391AbUE2UA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUE2UA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 16:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUE2UA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 16:00:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44247 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264391AbUE2UAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 16:00:25 -0400
Message-ID: <40B8EBCB.3010701@pobox.com>
Date: Sat, 29 May 2004 16:00:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] remove net driver ugliness that sparse complains about
References: <40B8D2F8.6090905@pobox.com> <jeaczraxvu.fsf@sykes.suse.de>
In-Reply-To: <jeaczraxvu.fsf@sykes.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> These two look wrong, too many &.


thanks, fixed
