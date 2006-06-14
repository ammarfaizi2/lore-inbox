Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWFNSUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWFNSUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 14:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWFNSUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 14:20:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932125AbWFNSUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 14:20:44 -0400
Date: Wed, 14 Jun 2006 11:20:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Andreassen <paul@andreassen.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp simple typo
In-Reply-To: <200606150359.20038.paul@andreassen.com.au>
Message-ID: <Pine.LNX.4.64.0606141119340.5498@g5.osdl.org>
References: <200606150359.20038.paul@andreassen.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Jun 2006, Paul Andreassen wrote:
> 
> No sure how this ever worked.

Already fixed in the current tree (and there was some discussion about 
how it didn't actually matter, because those control registers are 
rewritten later, but it was definitely a bug).

		Linus
