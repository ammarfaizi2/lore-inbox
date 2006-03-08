Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWCHVZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWCHVZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWCHVZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:25:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34513 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932424AbWCHVZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:25:28 -0500
Date: Wed, 8 Mar 2006 21:25:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] NFS: Permit filesystem to override root dentry on mount [try #7]
Message-ID: <20060308212524.GA8042@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
	aviro@redhat.com, linux-fsdevel@vger.kernel.org,
	nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
References: <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

could you please remove the linux-cachefs list from the cc list?  It's
subscribers only and gives an annoying bounce for every message replied
to yours.
