Return-Path: <linux-kernel-owner+w=401wt.eu-S932074AbWLNK2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWLNK2T (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWLNK2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:28:19 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50543 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751851AbWLNK2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:28:18 -0500
Date: Thu, 14 Dec 2006 10:36:13 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: corbet@lwn.net (Jonathan Corbet)
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
Message-ID: <20061214103613.49965c91@localhost.localdomain>
In-Reply-To: <22299.1166057009@lwn.net>
References: <20061214003246.GA12162@suse.de>
	<22299.1166057009@lwn.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2008?  I bet a lot of people would read the above to say that their
> system will just drop dead of a New Year's hangover, and they'll freak.
> I wouldn't want to be the one getting all the email at that point...

I wouldn't worry. Everyone will have patched it back out again by then,
or made their driver lie about the license. Both of which make the
problem worse not better when it comes to debugging.

Alan
