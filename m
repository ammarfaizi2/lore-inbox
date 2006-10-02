Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWJBQ1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWJBQ1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbWJBQ1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:27:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63675 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965077AbWJBQ1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:27:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061002085744.55bf8c28.rdunlap@xenotime.net> 
References: <20061002085744.55bf8c28.rdunlap@xenotime.net>  <20061002153708.22649.96337.stgit@warthog.cambridge.redhat.com> 
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FRV: Permit large kmalloc allocations 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 02 Oct 2006 17:27:36 +0100
Message-ID: <17963.1159806456@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@xenotime.net> wrote:

> > +	  sizes - upto 32MB. You may need this if your system has a lot of RAM,
> 
> 		up to (2 words)

Altered, thanks.

David
