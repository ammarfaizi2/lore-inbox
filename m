Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUGHWHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUGHWHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUGHWHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:07:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:54991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261234AbUGHWH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:07:27 -0400
Date: Thu, 8 Jul 2004 15:02:22 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Christian Kujau <evil@g-house.de>, akpm <akpm@osdl.org>
Cc: drightler@technicalogic.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 "Unable to handle kernel paging request" plus kobject_get
 badness
Message-Id: <20040708150223.2fa765bf.rddunlap@osdl.org>
In-Reply-To: <40EDC3C3.40302@g-house.de>
References: <004101c462c8$b870fbd0$0200000a@darkomen.lan>
	<40EDC3C3.40302@g-house.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jul 2004 23:59:31 +0200 Christian Kujau wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| Dwayne Rightler schrieb:
| > Hello,
| >
| > I've never reported a kernel error before so please let me know if
| there is
| > more info I can provide.  Running 2.6.7 with the kexec patch.  Was not
| > having these problems with 2.6.5 with the kexec patch.
| 
| did you contact te maintainer of this patch?
| (you should do so)

He did (indirectly), i.e., I read it, but I don't see anything
here that is kexec-related...

Andrew, do you recognize this Oops?
  http://marc.theaimsgroup.com/?l=linux-kernel&m=108905677320691&w=2

--
~Randy
