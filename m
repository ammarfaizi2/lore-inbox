Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWCRIx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWCRIx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 03:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWCRIx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 03:53:28 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:29875 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932306AbWCRIx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 03:53:27 -0500
Date: Sat, 18 Mar 2006 09:51:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.16-rc6 patch] fix interactive task starvation
Message-ID: <20060318085113.GA23317@elte.hu>
References: <1142658480.8262.38.camel@homer> <20060317211529.26969a16.akpm@osdl.org> <1142661030.8937.7.camel@homer> <20060317222203.06d7f450.akpm@osdl.org> <1142666985.7881.5.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142666985.7881.5.camel@homer>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> Signed-off-by: Mike Galbraith <efault@gmx.de>

looks good to me.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
