Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422627AbWIGRRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422627AbWIGRRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 13:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbWIGRRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 13:17:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43734 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161059AbWIGRRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 13:17:49 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <44C9D0FE.9090004@garzik.org> 
References: <44C9D0FE.9090004@garzik.org>  <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com> 
To: Jeff Garzik <jeff@garzik.org>, trond.myklebust@fys.uio.no,
       hch@infradead.org
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, tburke@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: FS-Cache patches
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Sep 2006 18:17:24 +0100
Message-ID: <20397.1157649444@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:

> I'm really looking forward to seeing this in the upstream kernel... thanks for
> your continued work on this.
> 
> (Although I admit to not reviewing 100% of the code)

Could you find some time to spare to review them?  You can grab them from:

	http://people.redhat.com/~dhowells/nfs/nfs+fscache-14.tar.bz2

Trond wants them to be reviewed by Christoph before accepting them, but I
don't Christoph has the time.  So if I could get someone else to review them
instead, maybe that'd satisfy him.

David
