Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVC2REU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVC2REU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 12:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVC2RDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 12:03:02 -0500
Received: from upco.es ([130.206.70.227]:19083 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261247AbVC2RCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 12:02:40 -0500
Date: Tue, 29 Mar 2005 19:02:38 +0200
From: Romano Giannetti <romanol@upco.es>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel
Message-ID: <20050329170238.GA8077@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Pavel Machek <pavel@ucw.cz>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050329132022.GA26553@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050329132022.GA26553@pern.dea.icai.upco.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 03:20:22PM +0200, Romano Giannetti wrote:
> >    swsusp is not working for me with 2.6.12rc1. I compiled the kernel
> >    preempt, I am compiling now without preempt to test it. -mm3 has a
> >    similar behaviour.
> 
> Tested with no-preempt -rc1-mm3. No joy; the suspend stops exactly at the
> same point. 

Double auto-answer. I have a serial console now; if anybody can help me to
explain why (after booting with console=ttyS0,115200 console=tty0) if I do a
sysrq-t on the serial console appears just the "[4295210.188000] SysRq :
Show State" and not the dump which appears only to the virtual console... 

then I can capture all the logs you like. 

Romano

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
