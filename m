Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265203AbUD3ScH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUD3ScH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbUD3ScG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:32:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24717 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265203AbUD3S3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:29:05 -0400
Date: Fri, 30 Apr 2004 14:28:44 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Guillaume Thouvenin <guillaume.thouvenin@polymtl.ca>
cc: Christoph Hellwig <hch@infradead.org>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       Paul Jackson <pj@sgi.com>, <chrisw@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
In-Reply-To: <1083323300.409233a4459e3@www.imp.polymtl.ca>
Message-ID: <Pine.LNX.4.44.0404301428120.6976-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Guillaume Thouvenin wrote:

> And what about put the management of containers outside the kernel.

User Mode Linux would be an option indeed, if the overhead
was low enough for general use.  It's quite possible that
this can be done...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

