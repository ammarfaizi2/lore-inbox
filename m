Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267613AbUHWJ3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267613AbUHWJ3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 05:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267617AbUHWJ3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 05:29:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:9900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267613AbUHWJ3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 05:29:20 -0400
Date: Mon, 23 Aug 2004 02:27:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] via-velocity: use common crc16 code for WOL
Message-Id: <20040823022729.09b7ce62.akpm@osdl.org>
In-Reply-To: <1093247839.2792.7.camel@laptop.fenrus.com>
References: <200408222213.i7MMDm57014913@hera.kernel.org>
	<1093247839.2792.7.camel@laptop.fenrus.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> On Sat, 2004-07-03 at 08:20, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1757.72.2, 2004/07/03 02:20:30-04:00, romieu@fr.zoreil.com
> > 
> > 	[PATCH] via-velocity: use common crc16 code for WOL
> > 	
> > 	- use common crc16 code for WOL;
> > 	- remove unused ether_crc.
> > 	
> 
> 
> ehhh my BK tree doesn't have linux/crc16.h ...
> 

Other patches are in flight.  It should be fixed tomorrow.
