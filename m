Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWC1R30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWC1R30 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWC1R30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:29:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49383 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751176AbWC1R3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:29:25 -0500
Subject: Re: RFC - Approaches to user-space probes
From: Arjan van de Ven <arjan@infradead.org>
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       davem@davemloft.net, suparna@in.ibm.com, richardj_moore@uk.ibm.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20060328145441.GA25465@in.ibm.com>
References: <20060327065447.GA25745@in.ibm.com>
	 <1143445068.2886.20.camel@laptopd505.fenrus.org>
	 <20060327100019.GA30427@in.ibm.com>
	 <1143489794.2886.43.camel@laptopd505.fenrus.org>
	 <20060328145441.GA25465@in.ibm.com>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 19:29:01 +0200
Message-Id: <1143566941.2885.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> But, if we do a objdump on the probed executable, we are seeing the
> breakpoints in the disassembly. We are looking into this issue.
> Does this mean that breakpoints are written to the disk?

it means tripwire and similar tools will raise big alarms at least.



