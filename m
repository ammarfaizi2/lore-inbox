Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTKLPIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTKLPHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:07:44 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:14783 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262186AbTKLPHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:07:38 -0500
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Some thoughts about stable kernel development
References: <m3u15de669.fsf@defiant.pm.waw.pl>
	<200311091905.hA9J5BiA004728@turing-police.cc.vt.edu>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 12 Nov 2003 16:05:41 +0100
In-Reply-To: <200311091905.hA9J5BiA004728@turing-police.cc.vt.edu>
Message-ID: <m3islp8w56.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> Two kernels getting different patches... (consider the case of a security
> patch that hits code that was already hit by a previous -preN-ony patch,
> so two different diffs are needed for the two trees)

Yes, this is theoretically possible. Do you think it would be a frequent
case?
-- 
Krzysztof Halasa, B*FH
