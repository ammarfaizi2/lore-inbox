Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWE3KgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWE3KgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWE3KgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:36:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59327 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932238AbWE3KgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:36:04 -0400
Date: Tue, 30 May 2006 11:35:50 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] NFS: Abstract out namespace initialisation [try #10]
Message-ID: <20060530103550.GV27946@ftp.linux.org.uk>
References: <20060519154640.11791.2928.stgit@warthog.cambridge.redhat.com> <20060519154650.11791.71116.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519154650.11791.71116.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 04:46:50PM +0100, David Howells wrote:
> The attached patch abstracts out the namespace initialisation so that temporary
> namespaces can be set up elsewhere.

IDGI...   Where does your patchset use it?
