Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUITNLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUITNLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 09:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbUITNLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 09:11:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26040 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266481AbUITNLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 09:11:07 -0400
Date: Mon, 20 Sep 2004 14:11:05 +0100
From: Matthew Wilcox <willy@debian.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] [PATCH] fix syntax error in asm-parisc/som.h
Message-ID: <20040920131105.GP642@parcelfarce.linux.theplanet.co.uk>
References: <20040918221928.GA28627@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040918221928.GA28627@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 12:19:28AM +0200, Olaf Hering wrote:
> 
> The comment is not closed.
> The file is also not used anywhere, maybe it can be removed.

Yep, I'll just remove it.  It'll be in the next PA merge.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
