Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTDGSSG (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTDGSSG (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:18:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60299 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263595AbTDGSSE (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 14:18:04 -0400
Message-ID: <3E91C398.9070400@pobox.com>
Date: Mon, 07 Apr 2003 14:29:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: SET_MODULE_OWNER?
References: <20030407064755.DEAD62C06C@lists.samba.org>
In-Reply-To: <20030407064755.DEAD62C06C@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> I thought it was completely useless, hence deprecated.
> 
> Anyone have any reason to defend it?


It's used to allow source compatibility with all kernels, old or new.

Thus it is in active use, and should not be removed.

	Jeff



