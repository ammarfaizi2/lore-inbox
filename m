Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUHSPBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUHSPBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUHSO7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:59:04 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:49095 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266349AbUHSO4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:56:07 -0400
Date: Thu, 19 Aug 2004 15:54:21 +0100
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: includes cleanup.
Message-ID: <20040819145421.GC4148@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com> <20040819154900.A10013@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819154900.A10013@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 03:49:00PM +0100, Christoph Hellwig wrote:
 > On Thu, Aug 19, 2004 at 03:39:07PM +0100, Dave Jones wrote:
 > > - split out the wake_up_* stuff to linux/wakeup.h
 > 
 > linux/wait.h sounds like a better choice because the other half of the
 > waitqueue operations are over there..

Sounds good to me. I'll make it happen.

		Dave

