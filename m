Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUIWPlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUIWPlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUIWPlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:41:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:51137 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266333AbUIWPlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:41:07 -0400
Date: Thu, 23 Sep 2004 08:35:21 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: yeyb03 <yeyb03@mails.tsinghua.edu.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: where can find the early-initcall macro definition.
Message-Id: <20040923083521.3decdc1f.rddunlap@osdl.org>
In-Reply-To: <295941326.00351@mails.tsinghua.edu.cn>
References: <295941326.00351@mails.tsinghua.edu.cn>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 20:17:46 +0800 yeyb03 wrote:

| hello everyone, where can find the early-initcall macro definition.

hi.

initcall macros are defined in $kernel_dir/include/linux/init.h;
however, there's not one named "*early*".

--
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
