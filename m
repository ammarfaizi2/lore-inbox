Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWHVOtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWHVOtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWHVOtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:49:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:63905 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932128AbWHVOtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:49:10 -0400
From: Andi Kleen <ak@suse.de>
To: Ian Campbell <Ian.Campbell@xensource.com>
Subject: Re: [PATCH 1 of 1] x86_64: Put .note.* sections into a PT_NOTE segment in vmlinux
Date: Tue, 22 Aug 2006 16:48:58 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@xensource.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization <virtualization@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
References: <1156256777.5091.93.camel@localhost.localdomain>
In-Reply-To: <1156256777.5091.93.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608221648.58080.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 August 2006 16:26, Ian Campbell wrote:
> This patch updates x86_64 linker script to pack any .note.* sections
> into a PT_NOTE segment in the output file.

Thanks added.

-Andi

P.S.: 2-3 paragraphs description would have been enough, but that is fine
too.
