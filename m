Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWG3RQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWG3RQF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWG3RQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:16:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:36053 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932341AbWG3RQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:16:03 -0400
From: Andi Kleen <ak@suse.de>
To: Valdis.Kletnieks@vt.edu
Subject: Re: Building the kernel on an SMP box?
Date: Sun, 30 Jul 2006 19:11:18 +0200
User-Agent: KMail/1.9.3
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com> <200607292129.17682.ak@suse.de> <200607301618.k6UGIHEt023129@turing-police.cc.vt.edu>
In-Reply-To: <200607301618.k6UGIHEt023129@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301911.18261.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 18:18, Valdis.Kletnieks@vt.edu wrote:

> What happens with the 'gcc version magic' with modules if the main kernel
> and modules are compiled on separate machines with different GCC releases
> installed?   Certainly seems like a requirement for a "similar" environment
> to me, if compiling with gcc 4.1.0 vs 4.1.1. results in a module that won't
> insmod....

Please read the icecream documentation.

-Andi

