Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWH2Qxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWH2Qxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWH2Qxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:53:43 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:60092 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S965148AbWH2Qxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:53:40 -0400
Date: Tue, 29 Aug 2006 17:53:52 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Lameter <clameter@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
Message-ID: <20060829165352.GA20453@linux-mips.org>
References: <20060829162055.GA31159@linux-mips.org> <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com> <5878.1156868702@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5878.1156868702@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 05:25:02PM +0100, David Howells wrote:

> Some of these have LL/SC or equivalent instead, but ARM5 and before, FRV, M68K
> before 68020 to name but a few.

68k before 68020 isn't supported by Linux anyway.

  Ralf
