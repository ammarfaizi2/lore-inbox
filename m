Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTDVSwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTDVSwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:52:42 -0400
Received: from customer204.globaltap.com ([206.104.238.204]:27074 "HELO
	annexa.net") by vger.kernel.org with SMTP id S263365AbTDVSwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:52:40 -0400
Subject: Re: Need help with lockups on tyan s2460 motherboard in SMP mode
From: James Strandboge <jamie@tpptraining.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1051018709.3235.55.camel@sirius.strandboge.cxm>
References: <1051018709.3235.55.camel@sirius.strandboge.cxm>
Content-Type: text/plain
Organization: Targeted Performance Partners, LLC
Message-Id: <1051038280.4690.26.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2003 15:04:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-22 at 09:38, James Strandboge wrote:

> The only way I have found to reliably crash the system is to compile two
> kernels simultaneously while in smp mode.  If I boot with 'nosmp' the
> system seems ok (still running and compiling after 9 hours).

Well, it crashed after 15 hours with nosmp.  Guess its hardware related.

Jamie
-- 
James Strandboge
Targeted Performance Partners, LLC
Web: http://www.tpptraining.com
E-mail: jamie@tpptraining.com
Tel: (585) 271-8370
Fax: (585) 271-8373

