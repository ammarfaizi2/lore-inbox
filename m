Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVCOWAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVCOWAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVCOWAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:00:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:54160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261910AbVCOWAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:00:09 -0500
Date: Tue, 15 Mar 2005 14:00:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] linux-2.6-watchdog-mm patches
Message-Id: <20050315140006.552c4c55.akpm@osdl.org>
In-Reply-To: <20050315214634.GC4909@infomag.infomag.iguana.be>
References: <20050315214634.GC4909@infomag.infomag.iguana.be>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wim Van Sebroeck <wim@iguana.be> wrote:
>
> please do a
> 
> 	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog-mm

I do, about three times a day ;) And I resolve conflicts between the bk
trees and Linus's tree.  And I resolve conflicts if there's a clash between
one bk tree and another.  And I'll let you know if there's some non-trivial
conflict looming between your tree and someone else's.  And I'll let you
know if there's a compile error or bug in your tree and might even have a
patch for it.

The only real problem with this scheme is that you don't know when I'm
about to release your tree in a -mm kernel.  So I don't support a "this
change is only half done but I'll check it in now" state.  That hasn't
caused any problem yet, as far as I know.
