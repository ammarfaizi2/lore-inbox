Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030911AbWKOTOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030911AbWKOTOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030913AbWKOTOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:14:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50660 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030901AbWKOTOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:14:05 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6134.1163617750@redhat.com> 
References: <6134.1163617750@redhat.com>  <26860.1163607813@redhat.com> <XMMS.LNX.4.64.0611151115360.8593@d.namei> <XMMS.LNX.4.64.0611141618300.25022@d.namei> <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> <15153.1163593562@redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be overridden 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 19:11:41 +0000
Message-ID: <6203.1163617901@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> I haven't removed the old fscreate overriding patch yet, not have I put in the
> error handling in CacheFiles.

that should read "... nor have I..."

David
