Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268479AbUIWONa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268479AbUIWONa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 10:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268483AbUIWONa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 10:13:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:5867 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268479AbUIWON3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 10:13:29 -0400
Date: Thu, 23 Sep 2004 07:07:44 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: manomugdha biswas <manomugdhab@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: function installation at shutdown (reboot)
Message-Id: <20040923070744.2f3cabd0.rddunlap@osdl.org>
In-Reply-To: <20040923130446.48494.qmail@web8501.mail.in.yahoo.com>
References: <20040923130446.48494.qmail@web8501.mail.in.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 14:04:46 +0100 (BST) manomugdha biswas wrote:

| Hi 
| Thanks for your comments.
| I tried to install a function using the fruntion
| register_reboot_notifier(). Installation was
| successfull but the installed function was not called
| at reboot time. I used kernel version 2.4.20-8. Could
| you please give me some light why this function is
| does not get installed?

No idea really.  How was reboot initiated?
Can you share some sample source code?

--
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
