Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261763AbSJCRNg>; Thu, 3 Oct 2002 13:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbSJCRNg>; Thu, 3 Oct 2002 13:13:36 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:39431
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261763AbSJCRNf>; Thu, 3 Oct 2002 13:13:35 -0400
Subject: Re: O(1) scheduler for 2.4.(19|20-pre.)?
From: Robert Love <rml@tech9.net>
To: Brandon Low <lostlogic@gentoo.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021003120329.H6891@lostlogicx.com>
References: <200210031148.23823.roy@karlsbakk.net>
	<1033647544.28022.2.camel@irongate.swansea.linux.org.uk> 
	<20021003120329.H6891@lostlogicx.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 13:18:29 -0400
Message-Id: <1033665510.743.27.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 13:03, Brandon Low wrote:

> Unfortunately some of the scheduler bits that have been merged into 
> 2.4.20-pre have broken the nice patch that robert has, I'm hoping he can 
> re-diff it for us (me) because I like to have the option of getting O(1) 
> without using Alan's tree.

I just put a 2.4.19 final patch up.  I will do a 2.4.20-pre/2.4.20 patch
eventually but it is not at the top of my list.  I would not think
managing the rejects is too difficult.

It is a much higher priority keeping the 2.4-ac and 2.5 scheduler sane.

	Robert Love

