Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVJVPJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVJVPJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 11:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVJVPJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 11:09:09 -0400
Received: from imag.imag.fr ([129.88.30.1]:36765 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1751237AbVJVPJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 11:09:08 -0400
Date: Sat, 22 Oct 2005 17:08:42 +0200
From: Jacques Moreau <jacques.moreau@imag.imag.fr>
To: linux-kernel@vger.kernel.org
Cc: Luke Yang <luke.adi@gmail.com>
Subject: Re: ADI Blackfin porting for kernel-2.6.13
Message-ID: <20051022150842.GA15174@linux.ensimag.fr>
Reply-To: 489ecd0c05091923336b48555@mail.gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Sat, 22 Oct 2005 17:08:43 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
Hi,


>   I am Luke Yang, an engineer from Analog Devices Inc. We ported
>uclinux to our Blackfin cpu. Now we updated our architecture code for
>kernel-2.6.13. I will send out a patch to this list.
Does this patch is only for Blackfin processor or it add some support for fusiv 
[1] communications processor that are in residential Gateway ?

If no, do you know if analog plans to realease the linux 2.4/2.6 modification
that have been made in order to support these processors ?

IRRC some Sagem residential Gateways[2] (will) run on 
Linux OS and the users sould be able ask for the GPL code.


Jacques




[1] http://www.analog.com/en/prod/0,2877,AD6502,00.html
[2] http://www.sagem.com/index.php?id=193&L=0
