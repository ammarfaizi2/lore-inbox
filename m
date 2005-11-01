Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVKAEw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVKAEw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVKAEwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:52:55 -0500
Received: from ozlabs.org ([203.10.76.45]:23689 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964950AbVKAEwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:52:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17254.62394.445512.359175@cargo.ozlabs.ibm.com>
Date: Tue, 1 Nov 2005 15:48:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't touch USB controllers with MMIO disabled in quirks
In-Reply-To: <Pine.LNX.4.64.0510312026300.27915@g5.osdl.org>
References: <17254.59690.713323.294726@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0510312026300.27915@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Would something like the appended work instead?

Looks fine to me, and it fixes the problem on my powerbook.

Paul.
