Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264849AbTFLPa1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264861AbTFLPa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:30:27 -0400
Received: from mail.skjellin.no ([80.239.42.67]:32996 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S264849AbTFLPa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:30:26 -0400
Subject: Re: [QUESTION] What about EtherLeak report from @stake
From: Andre Tomt <andre@tomt.net>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030612172426.0a3a60d9.martin.zwickel@technotrend.de>
References: <20030612172426.0a3a60d9.martin.zwickel@technotrend.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1055432648.976.136.camel@slurv.ws.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 12 Jun 2003 17:44:08 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 17:24, Martin Zwickel wrote:
> Hi there!
> 
> What do you think about this:
> 
> http://www.atstake.com/research/advisories/2003/atstake_etherleak_report.pdf
> http://www.kb.cert.org/vuls/id/412115
> 
> Are those padding bug's fixed in >=2.5.x/2.4.21?
> 
> Or isn't it that critical?


It was fixed in 2.4.x early 2.4.21-pre, and in 2.2.2x sometime I dont
really recall. It's also fixed in 2.5.x, according to linux.bkbits.net.

Most vendor kernels are fixed, too.

-- 
Cheers,
André Tomt

