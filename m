Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbULKXtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbULKXtI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 18:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbULKXtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 18:49:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20136 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261959AbULKXtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 18:49:06 -0500
Date: Sat, 11 Dec 2004 19:24:50 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: tvrtko.ursulin@sophos.com
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, urban@teststation.com
Subject: Re: [BUG ?] smbfs open always succeeds
Message-ID: <20041211212450.GI9995@logos.cnet>
References: <OF30DAAE12.E64B9793-ON80256F66.003C453F-80256F66.003D0A18@sophos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF30DAAE12.E64B9793-ON80256F66.003C453F-80256F66.003D0A18@sophos.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 11:06:42AM +0000, tvrtko.ursulin@sophos.com wrote:
> >It seems Andrew applied this to the -mm tree.
> >
> >smb_file_open-retval-fix.patch
> 
> Hm, I guess I should have spotted that but unfortunately I don't have 
> enough time to keep up with mm lately. :I
> 
> Marcelo, are you planning to put it in 2.4 ?

After it has been present in a major v2.6 release (v2.6.11) for a few months
to guarantee there are no negative side effects, yes.

Written to my whiteboard as a remainder, my memory is quite bad. :) 

