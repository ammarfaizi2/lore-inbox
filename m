Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUJOQoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUJOQoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268175AbUJOQlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:41:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31936 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268169AbUJOQkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:40:39 -0400
Subject: Re: [Ext2-devel] Ext3 -mm reservations code: is this fix really
	correct?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1097856114.4591.28.camel@localhost.localdomain>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	 <1097856114.4591.28.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1097858401.1968.148.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Oct 2004 17:40:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-10-15 at 17:01, mingming cao wrote:

> > Have I misunderstood something?
> > 
> You are correct, again:) We should do a search_reserve_window() from the
> root.
> 
> I will post a fix for these two soon.

Thanks.  I'll be away for a few days so I probably won't be able to look
at the fix until Wednesday next week.

Cheers,
 Stephen

