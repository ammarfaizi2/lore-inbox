Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268577AbUJDVUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268577AbUJDVUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268575AbUJDVUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:20:50 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57033 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268577AbUJDVUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:20:16 -0400
Subject: Re: [PATCH] AES x86-64-asm impl.
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Andi Kleen <ak@muc.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Florian Bohrer <florian.bohrer@t-online.de>,
       linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org
In-Reply-To: <4161A3DA.4000708@tmr.com>
References: <2KWl4-wq-25@gated-at.bofh.it>
	 <416142DD.54E0E417@users.sourceforge.net>  <4161A3DA.4000708@tmr.com>
Content-Type: text/plain
Message-Id: <1096924814.16648.71.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 17:20:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 15:26, Bill Davidsen wrote:
> Jari Ruusu wrote:
> > Paolo Ciarrocchi wrote:
> > 
> >>On Mon, 04 Oct 2004 15:20:43 +0300, Jari Ruusu
> >>I understand that, I still don't understand the reaseon.
> >>But hey, feel free to ignore my question ;)
> > 
> > 
> > You haven't looked at cryptoloop security, have you?
> > 
> > No sane person wants to be accociated with that kind of broken and
> > backdoored scam. I certainly don't.
> > 
> Would you be happy if the code were wrapped as a general use package 
> like blowfish, or have you decided that because one part of Linux 
> doesn't meet your standards you don't want to allow any of your code to 
> be used in it?
> 

Please check the archives, Jari's reasons are well documented.  I cannot
summarize the technical issues here as IANA cryptographer but please,
let's not start that thread again.

Lee 

