Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbTEKUdp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 16:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbTEKUdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 16:33:45 -0400
Received: from AMarseille-201-1-2-138.w193-253.abo.wanadoo.fr ([193.253.217.138]:34087
	"EHLO gaston") by vger.kernel.org with ESMTP id S261201AbTEKUdo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 16:33:44 -0400
Subject: Re: PATCH 2.5.69 drivers/macintosh/adbhid.c && QUESTIONS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniele Pala <dandario@libero.it>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030507153134.GA344@libero.it>
References: <20030507153134.GA344@libero.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052685963.12188.120.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 May 2003 22:46:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 17:31, Daniele Pala wrote:
> This fixes a supid syntax error in adbhid.c
> The question is: is there a PPC mantainer who i must send patches for PPC? or i just drop them here in the list?
> There are other few errors in PPC related files that sometimes prevents the kernel from compiling...supid things, but
> annoying...so who gets the PPC stuff?

There is a PowerMac maintainer, me ;) Though I've been a bit busy with
other things than 2.5 PowerMac drivers lately, still send me the patches.

You will also have more luck using the bk://ppc.bkbits.net/linuxppc-2.5
tree until all of our stuff is properly merged upstream

Ben.

