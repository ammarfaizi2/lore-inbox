Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUH2PjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUH2PjD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUH2PjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:39:02 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13441 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267976AbUH2PjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:39:00 -0400
Subject: Re: Termination of the Philips Webcam Driver (pwc)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Craig Milo Rogers <rogers@isi.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org>
References: <20040826233244.GA1284@isi.edu>
	 <20040827004757.A26095@infradead.org>
	 <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093790181.27934.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 15:36:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-27 at 01:03, Linus Torvalds wrote:
> Yes and no. From a legal standpoint you're right. However, we should also 
> be polite. If he's the sole author, and he asks for it, I think it's 
> reasonable to honor his wishes.

He is not sole author. Large parts of the code are based on other
authors work and simply copied from the standard framework. Please put
back the version without the hooks. It is useful to all sorts of people
in that form.

When the author GPL'd it he gave up his rights to remove it. Expecting
people to clean-room reverse engineer GPL source is a joke.

Alan

