Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbUAHHha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 02:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbUAHHha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 02:37:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:16873 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263792AbUAHHhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 02:37:23 -0500
Date: Wed, 7 Jan 2004 23:37:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0] autonegotiation broken with 3c905C
Message-Id: <20040107233740.02eef9ff.akpm@osdl.org>
In-Reply-To: <20040107133952.GA1877@deneb.enyo.de>
References: <20040107133952.GA1877@deneb.enyo.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> wrote:
>
> On Linux 2.6.0 (and earler -test versions), the card is stuck in
>  10-BaseT half-duplex mode, at least according to mii-tool.  The abysmal
>  TCP performance for bulk transfers *from* that host suggests that it's
>  true. 8-(

grr, someone should fix this.

Could you please gather all the info which is described in
Documentation/networking/vortex.txt under both 2.4 and 2.6 and send it to
me?  I'll see if I can remember how the darn thing works.

Thanks.
