Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWIPS6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWIPS6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 14:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWIPS6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 14:58:23 -0400
Received: from fmmailgate09.web.de ([217.72.192.184]:5268 "EHLO
	fmmailgate09.web.de") by vger.kernel.org with ESMTP
	id S1751129AbWIPS6X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 14:58:23 -0400
Reveived: from web.de 
	by fmmailgate09.web.de (Postfix) with SMTP id 5AE0A1C1A74;
	Sat, 16 Sep 2006 20:58:21 +0200 (CEST)
Date: Sat, 16 Sep 2006 20:58:20 +0200
Message-Id: <1313042030@web.de>
MIME-Version: 1.0
From: devzero@web.de
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: show all modules which taint the kernel ?
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

but that "Modules linked in: radeon(U) drm(U) ipv6(U) autofs4(U)...." message has been reported to originate from a fc5 (fedora) kernel. fedora probably also using that novell/suse extension ?


> -----Ursprüngliche Nachricht-----
> Von: Lee Revell <rlrevell@joe-job.com>
> Gesendet: 16.09.06 18:26:52
> An: devzero@web.de
> CC: linux-kernel@vger.kernel.org
> Betreff: Re: show all modules which taint the kernel ?


> On Sat, 2006-09-16 at 12:25 +0200, devzero@web.de wrote:
> > i wonder how someone can have so many tainted modules loaded at the
> > same time, so i`m unsure if (U) means "tainted" in this context.
> > 
> > can someone probably explain ?
> > 
> 
> The (U) thing is a Novell/SuSE extension.  Problems with vendor kernels
> should be reported to the vendor rather than LKML.
> 
> Lee
> 


_______________________________________________________________________
Viren-Scan für Ihren PC! Jetzt für jeden. Sofort, online und kostenlos.
Gleich testen! http://www.pc-sicherheit.web.de/freescan/?mc=022222

