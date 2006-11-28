Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935982AbWK1Rpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935982AbWK1Rpk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 12:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935983AbWK1Rpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 12:45:40 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:19366 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S935982AbWK1Rpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 12:45:39 -0500
Subject: Re: Scenario passes on 2.6.15.26 but fails on 2.6.11.4-20a kernel
From: Lee Revell <rlrevell@joe-job.com>
To: realales <realales@mail.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4565BC7E.3020406@mail.ru>
References: <4565BC7E.3020406@mail.ru>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 12:46:03 -0500
Message-Id: <1164735964.1701.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 18:21 +0300, realales wrote:
> Also I analyzed XTEST sources without any success.
> I know that this is unlikely the right place to ask this but could 
> someone please point me on the right way to move further?! Or may it
> be already a know problem for somebody? 

Sounds like a bug that was fixed between 2.6.11 and 2.6.15.  As 2.6.11
is no longer maintained, there's not much that can be done about it,
unless you can convince your vendor to backport a fix...

Lee

