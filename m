Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUEDKB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUEDKB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 06:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbUEDKB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 06:01:27 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:51213 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264299AbUEDKBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 06:01:25 -0400
Date: Tue, 4 May 2004 11:01:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NUMA API
Message-ID: <20040504110120.A21272@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ulrich Drepper <drepper@redhat.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <409201BE.9000909@redhat.com> <20040430083017.GB1298@holomorphy.com> <40969175.2020603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40969175.2020603@redhat.com>; from drepper@redhat.com on Mon, May 03, 2004 at 11:37:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 11:37:41AM -0700, Ulrich Drepper wrote:
> I do not claim to be the expert when it comes to all the fancy NUMA
> functionality.  But I surely can recognize a broken library interface.
> *That's* my concern.  I do not yet care too much about the kernel interface.

Then it's rather offtopic for this list.  If you need additions and/or changes
to the kernel interface to your library we'd love to hear about that as early
as possible, though.

