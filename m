Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264867AbUD2VO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264867AbUD2VO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264853AbUD2VOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:14:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:20963 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264860AbUD2VMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:12:07 -0400
Date: Thu, 29 Apr 2004 14:14:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: cltien@cmedia.com.tw, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH]: cmpci 6.82 released
Message-Id: <20040429141428.723e325c.akpm@osdl.org>
In-Reply-To: <20040429194635.GB20141@logos.cnet>
References: <92C0412E07F63549B2A2F2345D3DB515F7D430@cm-msg-02.cmedia.com.tw>
	<20040429194635.GB20141@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> > The cmpci-6.82-patch2.6.tar.bz2 is from official kernel 2.6.5, it will
> > show error when patch cmpci.c for kernel 2.6.4 or earlier, that's ok.
> 
> C.L. Tien,
> 
> I see your fixes have not yet been merged into v2.6.x mainline.
> 
> I dont know the card very well, but the fixes alright.
> 
> Andrew, maybe you can merge this in -mm?

It's still sitting in my to-do mailbox.  Last time we went through the cmpci
patch it was reverting a number of changes which other developers had
added to the tree, so it needs checking for that.

OK, the 6.82 2.6 patch seems OK from that point of view.  Will move it
forward.
