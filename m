Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbUKQRVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUKQRVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbUKQRUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:20:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:37861 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262450AbUKQRTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:19:52 -0500
Subject: Re: GPL version, "at your option"?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0411170822200.2222@ppc970.osdl.org>
References: <1100614115.16127.16.camel@ghanima>
	 <Pine.LNX.4.53.0411161547260.7946@gockel.physik3.uni-rostock.de>
	 <Pine.LNX.4.58.0411160746030.2222@ppc970.osdl.org>
	 <1100704183.32677.28.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411170822200.2222@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100708189.512.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 16:16:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-17 at 16:28, Linus Torvalds wrote:
> In other words, if you didn't have that "v2 or later" in your original 
> patches, they were _always_ just the regular GPLv2.

I did have that.

> That said, when I clarified (and I do want to make clear that the header 
> on the COPYING file is a _clarification_, not a change of license) it, I 
> told people that if they disagreed with me, they should send in patches 
> saying "v2 or later" to their own code.

Well no obligation exists, but please add "All code owned by Alan Cox
and present in this kernel is licensed GPL v2 or later" to your copying
or another appropriate file. (A comment in the code for each one would
be rather messy)

It might be a good idea to figure out how to have a list of contributors
who've said that or "v2 - or if Linus Torvalds so chooses, a later
version"

> Note the "IF". Linux _never_ had the "v2 or later" clause, so that "if" 
> was never an issue, and the clarification on top of the COPYING file 
> really _is_ just a clarification.

Correction noted. I went and checked 1.2.0 and indeed it says nothing
about versions in that specific top level file.

Alan

