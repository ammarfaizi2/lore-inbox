Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUDXDQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUDXDQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 23:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUDXDQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 23:16:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:61569 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261862AbUDXDQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 23:16:29 -0400
Date: Fri, 23 Apr 2004 20:15:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: alex@foogod.com, linux-fbdev-devel@lists.sourceforge.net,
       geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [PATCH] neofb patches
Message-Id: <20040423201536.6aefe7ad.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0404232241260.5826-100000@phoenix.infradead.org>
References: <56202.64.139.3.221.1082702638.squirrel@www.foogod.com>
	<Pine.LNX.4.44.0404232241260.5826-100000@phoenix.infradead.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Apr 2004 00:00:23 +0100 (BST) James Simmons <jsimmons@infradead.org> wrote:

| 
| > Ok, I've got everything except the blanking patch (which isn't finished
| > anyway) converted to apply cleanly to James' patched driver source. 
| > Everything works fine on my laptop as far as I can tell.  Additional
| > feedback is welcome.
| > 
| > I've put up a web page for the patches.  They can be found at
| > http://www.foogod.com/~alex/neofb/
| 
| Got it. I merged your patches. I also did a few fixes. The code had issues 
| with non byte align images, i.e sparc 12x22 fonts. Now it works. I posted 
| at
| 
| http://phoenix.infradead.org:~/jsimmons/neofb.diff.gz
| 
| This is against the latest kernel.

Hi James,

I think it would help a bit if someone could load
http://phoenix.infradead.org/~jsimmons/ in a web browser
and be able to see a list of files/patches/etc there
instead of having to know an exact file name to grab.

--
~Randy
