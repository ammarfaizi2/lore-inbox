Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268266AbUHXUT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268266AbUHXUT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUHXUT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:19:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3970 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268266AbUHXUTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:19:23 -0400
Date: Tue, 24 Aug 2004 16:19:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andreas Gruenbacher <agruen@suse.de>
cc: Christoph Hellwig <hch@infradead.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][1/7] xattr consolidation - libfs
In-Reply-To: <1093376572.20259.115.camel@winden.suse.de>
Message-ID: <Xine.LNX.4.44.0408241618430.21512-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Andreas Gruenbacher wrote:

> If we decide to remove dynamic handler registration, simple_xattr_list
> should go as well, and the listxattr iops can enumerate all existing
> handlers explicitly.

Ok, I should have an updated patch ready within a day or so.


- James
-- 
James Morris
<jmorris@redhat.com>


