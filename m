Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbULEP54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbULEP54 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 10:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbULEP54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 10:57:56 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:65290 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261200AbULEP5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 10:57:54 -0500
Date: Sun, 5 Dec 2004 16:57:43 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: David Greaves <david@dgreaves.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Rob Landley <rob@landley.net>,
       Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, Mariusz Mazur <mmazur@kernel.pl>,
       Arjan van de Ven <arjanv@redhat.com>, andersen@codepoet.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041205155743.GA24304@pclin040.win.tue.nl>
References: <19865.1101395592@redhat.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <41AAA746.5000003@pobox.com> <200412041949.57466.rob@landley.net> <20041205022613.GA13494@pclin040.win.tue.nl> <41B30AF2.6060505@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B30AF2.6060505@dgreaves.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2004 at 01:19:46PM +0000, David Greaves wrote:
> Err,
> 
> Isn't this WRONG.

You did not read my mail, or you did not understand it.

Please write the patch for losetup to avoid looking at kernel source.
If you after writing think that it is cleaner than the present setup,
submit it.

> Should it not be determining the kernel version at runtime and using the 
> right structures then?

See - you do not understand at all.
The structures do not depend on the kernel version.

Andries
