Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVBXIEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVBXIEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 03:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVBXIEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 03:04:41 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10651 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261895AbVBXIEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 03:04:34 -0500
Date: Thu, 24 Feb 2005 09:04:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/13] improve pinned task handling
Message-ID: <20050224080407.GB7847@elte.hu>
References: <1109229293.5177.64.camel@npiggin-nld.site> <1109229362.5177.67.camel@npiggin-nld.site> <1109229415.5177.68.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109229415.5177.68.camel@npiggin-nld.site>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> 2/13

yeah, we need this. (Eventually someone should explore a different way
to handle affine tasks as this is getting quirky, although it looks
algorithmically impossible in an O(1) way.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
