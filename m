Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVKJXcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVKJXcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVKJXcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:32:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751231AbVKJXck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:32:40 -0500
Date: Thu, 10 Nov 2005 15:32:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: andrea@suse.de, hugh@veritas.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC] sys_punchhole()
Message-Id: <20051110153254.5dde61c5.akpm@osdl.org>
In-Reply-To: <1131664994.25354.36.camel@localhost.localdomain>
References: <1131664994.25354.36.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> We discussed this in madvise(REMOVE) thread - to add support 
> for sys_punchhole(fd, offset, len) to complete the functionality
> (in the future).
> 
> http://marc.theaimsgroup.com/?l=linux-mm&m=113036713810002&w=2
> 
> What I am wondering is, should I invest time now to do it ?

I haven't even heard anyone mention a need for this in the past 1-2 years.

> Or wait till need arises ? 

A long wait, I suspect..
