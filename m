Return-Path: <linux-kernel-owner+w=401wt.eu-S932528AbXAIXdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbXAIXdR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbXAIXdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:33:17 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:52023
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932528AbXAIXdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:33:16 -0500
Date: Tue, 09 Jan 2007 15:33:15 -0800 (PST)
Message-Id: <20070109.153315.48802683.davem@davemloft.net>
To: akpm@osdl.org
Cc: torvalds@osdl.org, khali@linux-fr.org, arvidjaar@mail.ru,
       linux-kernel@vger.kernel.org, apw@shadowen.org, herbert@13thfloor.at,
       olaf@aepfle.de
Subject: Re: .version keeps being updated
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070109152534.ebfa5aa8.akpm@osdl.org>
References: <20070109133121.194f3261.akpm@osdl.org>
	<Pine.LNX.4.64.0701091520280.3594@woody.osdl.org>
	<20070109152534.ebfa5aa8.akpm@osdl.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Tue, 9 Jan 2007 15:25:34 -0800

> On Tue, 9 Jan 2007 15:21:51 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > On Tue, 9 Jan 2007, Andrew Morton wrote:
> > > 
> > > > This new behavior of the kernel build system is likely to
> > > > make developers angry pretty quickly.
> > > 
> > > That might motivate them to fix it ;)
> > 
> > Actually, how about just removing the incrementing version count entirely?
> 
> I use it pretty commonly to answer the question "did I remember to install
> that new kernel I just built before I rebooted"?  By comparing `uname -a'
> with $TOPDIR/.version.

Yeah me too :-)
