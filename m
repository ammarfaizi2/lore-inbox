Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbTAPS7D>; Thu, 16 Jan 2003 13:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTAPS7D>; Thu, 16 Jan 2003 13:59:03 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:51379 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267219AbTAPS7C>; Thu, 16 Jan 2003 13:59:02 -0500
Date: Thu, 16 Jan 2003 10:59:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>
cc: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
Message-ID: <19220000.1042743543@flay>
In-Reply-To: <Pine.LNX.4.44.0301162006280.9051-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0301162006280.9051-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> well, it needs to settle down a bit more, we are technically in a
> codefreeze :-)

The current codeset is *completely* non-invasive to non-NUMA systems.
It can't break anything.

M.

