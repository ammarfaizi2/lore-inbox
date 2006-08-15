Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965293AbWHOIV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965293AbWHOIV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 04:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWHOIV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 04:21:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19584 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965293AbWHOIV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 04:21:57 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <625fc13d0608141736q50dea86dh94cdf4ef19fe56d9@mail.gmail.com> 
References: <625fc13d0608141736q50dea86dh94cdf4ef19fe56d9@mail.gmail.com>  <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com> 
To: "Josh Boyer" <jwboyer@gmail.com>
Cc: "David Howells" <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org#
Subject: Re: [PATCH 0/4] Use 64-bit inode numbers internally in the kernel 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 09:21:53 +0100
Message-ID: <7329.1155630113@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Boyer <jwboyer@gmail.com> wrote:

> Out of curiosity, is there a performance hit for 32-bit systems?  Have
> you done any minimal benchmarks to see?

Yes, I'm sure there is, but we're talking performance vs correctness.

David
