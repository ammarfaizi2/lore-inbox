Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUJORKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUJORKC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUJORKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:10:02 -0400
Received: from [213.146.154.40] ([213.146.154.40]:51679 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S268212AbUJORI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:08:58 -0400
Subject: Re: Fw: signed kernel modules?
From: David Woodhouse <dwmw2@infradead.org>
To: root@chaos.analogic.com
Cc: Josh Boyer <jdub@us.ibm.com>, gene.heskett@verizon.net,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
In-Reply-To: <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
References: <27277.1097702318@redhat.com>
	 <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com>
	 <1097843492.29988.6.camel@weaponx.rchland.ibm.com>
	 <200410151153.08527.gene.heskett@verizon.net>
	 <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
	 <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1097860121.13633.358.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 15 Oct 2004 18:08:42 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 12:59 -0400, Richard B. Johnson wrote:
> We let this start when there were problems with secret video
> modules. Nobody wanted to debug a kernel that could be corrupted
> by a module where nobody could read the source-code. So if there
> isn't a MODULE_LICENSE("POLICY") then a 'tainted' mark goes
> in any OOPS report. Well, they got away with that. It was
> explained away as being "good" policy. Now they are making
> more policy.

Please quit being a fuckwit, Richard. You've escaped my killfile so far
despite being in so many other peoples, because it's often amusing to
find the deliberate mistake in your posts when they actually appear
plausible. 

The above is not policy; it's a mechanism. It provides the information.
Developers _use_ that information to implement their own policy, and
refrain from helping those whose kernels are tainted. 

Signing kernel modules is just the same. 

-- 
dwmw2

