Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUB0WiC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbUB0WiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:38:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:21150 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263171AbUB0Wh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:37:59 -0500
Date: Fri, 27 Feb 2004 14:39:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: riel@redhat.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
Message-Id: <20040227143945.2bddbd55.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0402272016170.19454@logos.cnet>
References: <20040227173250.GC8834@dualathlon.random>
	<Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
	<20040227122936.4c1be1fd.akpm@osdl.org>
	<Pine.LNX.4.58L.0402272016170.19454@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> Andrew, are your testcases online somewhere?

Well the tools are in ext3 CVS (http://www.zip.com.au/~akpm/linux/ext3/)
but the issue is how to drive them to create a particular scenario.

I never wrote that down, but there's heaps and heaps of info in the
changelogs:

http://linux.bkbits.net:8080/linux-2.5/user=akpm/ChangeSet?nav=!-|index.html|stats|!+|index.html

22000 lines of stuff there, so `bk revtool' and a fast computer may be a
more convenient navigation system.

That's not particularly useful, sorry.
