Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbVKWHz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVKWHz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 02:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbVKWHz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 02:55:29 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:44942 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1030351AbVKWHz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 02:55:28 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Dave Jones <davej@redhat.com>
Cc: gcoady@gmail.com, Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       david.fox@linspire.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2 pci_ids.h cleanup is a pain
Date: Wed, 23 Nov 2005 18:55:19 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <nt78o1ttracs6j168oqat9r47c5fd8murp@4ax.com>
References: <438249CB.8050200@linspire.com> <20051121224438.GA18966@kroah.com> <20051122162558.702fae4a.akpm@osdl.org> <41i7o11nbvrfrd8n2ev6kf11qjfjbil3jr@4ax.com> <20051123041917.GA27358@redhat.com>
In-Reply-To: <20051123041917.GA27358@redhat.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005 23:19:17 -0500, Dave Jones <davej@redhat.com> wrote:

>Three. I already mentioned we broke the compilation of the
>advansys driver because of this.

Nah, two.  Dave J. is the other, broken BROKEN driver, out of tree 
for working driver, patches not in mainline?  

I may have misunderstood...  You want advansys back?  Perhaps my 
boo-boo for not checking with allyesconfig + BROKEN re: unused 
symbols?

Grant.
