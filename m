Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWHXUYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWHXUYd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWHXUYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:24:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15546 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422657AbWHXUYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:24:32 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060824131544.aa9223f0.pj@sgi.com> 
References: <20060824131544.aa9223f0.pj@sgi.com> 
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fs cache patch breaks sparc build in 2.6.18-rc4-mm2 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 24 Aug 2006 21:24:21 +0100
Message-ID: <9699.1156451061@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:

> Looking at line numbers 326-337 in the file fs/afs/file.c, I see:

Andrew has a patch for that (fs-cache-make-kafs-use-fs-cache-12-fix.patch).

David
