Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUCJFdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 00:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUCJFdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 00:33:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:59090 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261947AbUCJFdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 00:33:13 -0500
Subject: Re: [PATCH] ppc64: Fix occasional crash at boot in OF interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <404EA513.5060703@tequila.co.jp>
References: <1078890877.9750.52.camel@gaston>
	 <404EA513.5060703@tequila.co.jp>
Content-Type: text/plain
Message-Id: <1078896591.9861.58.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 16:29:51 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-10 at 16:18, Clemens Schwaighofer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Benjamin Herrenschmidt wrote:
> 
> is there a reason why you dropped all the comments ?

I dropped the obviously useless ones yes.

Ben.


