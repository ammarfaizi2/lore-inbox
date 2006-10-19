Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946428AbWJSUKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946428AbWJSUKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946430AbWJSUKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:10:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:2770 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946428AbWJSUKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:10:34 -0400
To: Avi Kivity <avi@qumranet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>
	<4537C807.4@us.ibm.com> <4537CC24.2070708@qumranet.com>
From: Andi Kleen <ak@suse.de>
Date: 19 Oct 2006 22:10:26 +0200
In-Reply-To: <4537CC24.2070708@qumranet.com>
Message-ID: <p73d58oawy5.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity <avi@qumranet.com> writes:
> 
> You're right that "big real" mode is not supported, but so far that
> hasn't been a problem.  Do you know of an OS that needs big real mode?

Some SUSE releases iso boot loader and FreeBSD

-Andi
