Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269435AbUH0AWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269435AbUH0AWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUH0AUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:20:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:13762 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269816AbUH0AEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:04:20 -0400
Date: Thu, 26 Aug 2004 17:03:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Craig Milo Rogers <rogers@isi.edu>, linux-kernel@vger.kernel.org
Subject: Re: Termination of the Philips Webcam Driver (pwc)
In-Reply-To: <20040827004757.A26095@infradead.org>
Message-ID: <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org>
References: <20040826233244.GA1284@isi.edu> <20040827004757.A26095@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004, Christoph Hellwig wrote:
> 
> It's not up to him to decide.  He can step down from his maintainership,
> but he can't force the driver to be removed.

Yes and no. From a legal standpoint you're right. However, we should also 
be polite. If he's the sole author, and he asks for it, I think it's 
reasonable to honor his wishes.

Of course if some new maintainer shows up and decides to infer how the 
device worked by looking at the original open-source code, that's also 
clearly fine.

I don't want people to play lawyer. Honoring peoples rights to the code 
they write is more important than just the law.

		Linus
