Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTJTNzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 09:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTJTNzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 09:55:46 -0400
Received: from math.ut.ee ([193.40.5.125]:57796 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262369AbTJTNzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 09:55:45 -0400
Date: Mon, 20 Oct 2003 16:55:39 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
In-Reply-To: <20031014232511.GA17741@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.GSO.4.44.0310201655210.18000-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you apply the following patch (2.6)?  I'm expecting it to print out that
> it hard-codes to 32mb.

> +		puts("Hard-coded\n");

Yes, hard-coded.

-- 
Meelis Roos (mroos@linux.ee)

