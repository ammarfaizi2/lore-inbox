Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTLSLGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 06:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTLSLGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 06:06:13 -0500
Received: from math.ut.ee ([193.40.5.125]:10643 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262425AbTLSLGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 06:06:10 -0500
Date: Fri, 19 Dec 2003 13:05:52 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
In-Reply-To: <20031218080216.A30913@lists.us.dell.com>
Message-ID: <Pine.GSO.4.44.0312191305180.8311-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In include/asm-i386/edd.h, change:
> #define DISK80_SIG_BUFFER 0x228
>
> to
>
> #define DISK80_SIG_BUFFER 0x2cc

Yes, this works fine for me with current 2.4.

-- 
Meelis Roos (mroos@linux.ee)

