Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWAITdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWAITdy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWAITdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:33:54 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29856 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751219AbWAITdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:33:53 -0500
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
	can't for a long time
From: Lee Revell <rlrevell@joe-job.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, yarick@it-territory.ru,
       lkml@metanurb.dk, s0348365@sms.ed.ac.uk, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060109202454.7548b566.diegocg@gmail.com>
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
	 <200601091403.46304.yarick@it-territory.ru>
	 <1136813783.8412.4.camel@localhost>
	 <200601091656.48355.yarick@it-territory.ru>
	 <1136822827.6659.25.camel@localhost.localdomain>
	 <20060109202454.7548b566.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 09 Jan 2006 14:33:50 -0500
Message-Id: <1136835231.9957.101.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 20:24 +0100, Diego Calleja wrote:
> El Mon, 09 Jan 2006 16:07:07 +0000,
> Alan Cox <alan@lxorguk.ukuu.org.uk> escribió:
> 
> > Currently Linux performance loading large binaries is at least
> > perceptually worse than Windows (some of that is perceptual tricks
> > windows apps pull, some of it real). There is an openoffice.org related
> > analysis project currently under way to sort that out.
> 
> Desktop performance has become a such hot topic that I wonder if
> it would be worth to setup a dedicated mailing list somewhere
> where all the parts involved (kernel, kde/gnome, x.org, libc) can
> analyze what are the real problems are.

There already is one:

http://lists.osdl.org/pipermail/desktop_architects/2005-December/thread.html#522

Lee

