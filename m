Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTLJPKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTLJPKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:10:44 -0500
Received: from math.ut.ee ([193.40.5.125]:20880 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S263592AbTLJPKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:10:41 -0500
Date: Wed, 10 Dec 2003 15:21:32 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
In-Reply-To: <20031020203338.GJ6062@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.GSO.4.44.0312101519590.26871-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Current 2.4.24-pre is also misbehaving - now it too finds only 32M RAM
on my Powerstack. 2.4.23-pre9 is OK.

-- 
Meelis Roos (mroos@linux.ee)

