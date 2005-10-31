Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVJaTJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVJaTJa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVJaTJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:09:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63178 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964794AbVJaTJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:09:29 -0500
Date: Mon, 31 Oct 2005 11:09:00 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/5] i386 generic cmpxchg
In-Reply-To: <4365736B.4050506@yahoo.com.au>
Message-ID: <Pine.LNX.4.62.0510311108470.5528@schroedinger.engr.sgi.com>
References: <436416AD.3050709@yahoo.com.au> <4364171C.7020103@yahoo.com.au>
 <Pine.LNX.4.61.0510301157440.1526@montezuma.fsmlabs.com> <4365736B.4050506@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Nick Piggin wrote:

> This is only in the !CONFIG_X86_CMPXCHG case, though, so the branch would
> only be there on a 386 kernel, I think?

Correct.

