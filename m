Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268489AbUIFTuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268489AbUIFTuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUIFTuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:50:22 -0400
Received: from baikonur.stro.at ([213.239.196.228]:36844 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268489AbUIFTuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:50:17 -0400
Date: Mon, 6 Sep 2004 21:50:16 +0200
From: maks attems <debian@sternwelten.at>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: minyard@wf-rch.cirr.com, nacc@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 2.6.9-rc1-bk11] cdu31a: fix msleep patch typo
Message-ID: <20040906195016.GD1891@stro.at>
References: <200409051725.i85HPAb03108@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409051725.i85HPAb03108@freya.yggdrasil.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Sep 2004, Adam J. Richter wrote:

> 	linux-2.6.9-rc1-bk11 integrated the patch "cdu31a: replace
> schedule_timeout() with msleep()".  That patch contained a typo,
> causing the cdu31a driver to fail to compile.  Here is a fix for
> the typo.

thanks it already got reported,
similiar patch from adrian bunk is on the way to be merged.
 
> 	Of course I have tested this patch to verify that it compiles.
> I do not, however, have a Sony cdu-31a or cdu-33a drive handy to actually
> test that the driver works.  I wonder if anyone out there still has a
> Sony cdu-31a or cdu-33a CD-ROM drive on a machine running Linux.
> 
> Signed-off-by:	Adam J. Richter <adam@yggdrasil.com>

wooow cool :)
sounds like you volounteer to maintain that beast?
do you want to be added to MAINTAINERS?


--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

