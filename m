Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVGMJRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVGMJRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 05:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVGMJRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 05:17:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6297 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261497AbVGMJQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 05:16:59 -0400
Subject: Re: Kernel BUG at objrmap:325 in 2.6.5-7.151-smp (SuSE, x86_64)
From: Arjan van de Ven <arjan@infradead.org>
To: Christian Boehme <Christian.Boehme@gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42D4D9BB.7010701@gwdg.de>
References: <42D4D9BB.7010701@gwdg.de>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 11:16:49 +0200
Message-Id: <1121246209.3959.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 11:07 +0200, Christian Boehme wrote:
> We often see the following kernel-bug in our logs:

you really should call SuSE support for this... after all that's what
you're paying them for ;)


> 
> kernel: Kernel BUG at objrmap:325
> kernel: invalid operand: 0000 [1] SMP
> kernel: CPU 0
> kernel: Pid: 4752, comm: mhd3d.opteron Tainted: G  U (2.6.5-7.151-smp SLES9_SP1_BRANCH-200503181131210000)

which modules do you use ?


