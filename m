Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263146AbSJBOyb>; Wed, 2 Oct 2002 10:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263147AbSJBOyb>; Wed, 2 Oct 2002 10:54:31 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:8209
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263146AbSJBOya>; Wed, 2 Oct 2002 10:54:30 -0400
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
From: Robert Love <rml@tech9.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021002140124.B2141@infradead.org>
References: <1033513407.12959.91.camel@phantasy>
	 <20021002140124.B2141@infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1033570799.24476.49.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 02 Oct 2002 11:00:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 09:01, Christoph Hellwig wrote:

> Patch looks good to me, and I'd really like to have it in XFS :)

Good :)

> BTW, now that you have the core functionality I wonder why you don't
> also add the cpu affinity syscalls..

I already wrote them for 2.4, although I guess I should redo them for
the new set_cpus_allowed()... I have been waiting to send them to
Marcelo to ensure the 2.5 interfaces were solid and did not change.  As
we approach the feature freeze, I guess we are getting there.

	Robert Love

