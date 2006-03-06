Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWCFC3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWCFC3U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 21:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWCFC3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 21:29:20 -0500
Received: from ozlabs.org ([203.10.76.45]:17560 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751331AbWCFC3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 21:29:20 -0500
Date: Mon, 6 Mar 2006 11:11:08 +1100
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
Subject: Re: [PATCH] adjust /dev/{kmem,mem,port} write handlers
Message-ID: <20060306001108.GH5552@krispykreme>
References: <44081B03.76F0.0078.0@novell.com> <1141378697.2883.39.camel@laptopd505.fenrus.org> <p738xrrd4l6.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p738xrrd4l6.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> If you mmap it doesn't make any sense to not have read/write.
> And they are sometimes quite useful for debugging.

Agreed, I use them quite a lot too.

Anton
