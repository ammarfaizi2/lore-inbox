Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWEIRlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWEIRlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWEIRlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:41:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24775 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750784AbWEIRlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:41:24 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Richard J Moore <richardj_moore@uk.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>, suparna@in.ibm.com
Subject: Re: [RFC] [PATCH 3/6] Kprobes: New interfaces for user-space probes
References: <20060509093614.GB26953@infradead.org>
	<OFB21F3208.CA125B3A-ON41257169.005345DD-41257169.005375F5@uk.ibm.com>
	<20060509151857.GB16332@infradead.org>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 09 May 2006 13:41:09 -0400
In-Reply-To: <20060509151857.GB16332@infradead.org>
Message-ID: <y0mk68vyu2y.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hch wrote:

> [...]  why the hell do you guys expect to get a huge piele of flaky
> code integrate that slows down pagecaches and adds thousands of
> lines of undebuggable and untestable code without submitting
> something that actually calls it. [...]

It is reasonable to want to see code that exercises this function.
Until systemtap does, hand-written examples can surely be provided.

- FChE
