Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933957AbWKWVHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933957AbWKWVHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933987AbWKWVHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:07:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11912 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933957AbWKWVHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:07:41 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061123134011.bfbe51a9.akpm@osdl.org> 
References: <20061123134011.bfbe51a9.akpm@osdl.org>  <Pine.LNX.4.64.0611230920230.27596@woody.osdl.org> <20061122132008.2691bd9d.akpm@osdl.org> <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com> <10937.1164282273@redhat.com> <20447.1164312071@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] WorkStruct: Shrink work_struct by two thirds 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 23 Nov 2006 21:04:37 +0000
Message-ID: <1016.1164315877@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> But please make sure it's all done this time.  ie: use grep.  Heaps of simple
> stuff got missed in the pt_regs conversion.  

grep isn't really good enough; I need to try to compile everything.  I must
get my hands on more compilers, and even then allyesconfig doesn't cover all
the options.

David
