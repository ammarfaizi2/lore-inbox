Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbUCZFAn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbUCZFAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:00:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:19337 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263940AbUCZFAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 00:00:38 -0500
Subject: Re: RadeonFB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Oystein Haare <lkml-account@mazdaracing.net>
Cc: Stewart Smith <stewart@flamingspork.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1080276555.1791.7.camel@dawn.private.network>
References: <1079366460.853.3.camel@dawn>  <1080187819.2763.1.camel@kennedy>
	 <1080254335.1195.37.camel@gaston>
	 <1080274786.1791.1.camel@dawn.private.network>
	 <1080275242.1475.36.camel@gaston>
	 <1080276555.1791.7.camel@dawn.private.network>
Content-Type: text/plain
Message-Id: <1080277094.1465.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 15:58:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-26 at 15:49, Oystein Haare wrote:
> Attached!
> 
> I use the ATI (fglrx) driver for XFree btw. 
> 
> On Fri, 2004-03-26 at 14:27, Benjamin Herrenschmidt wrote:
> > On Fri, 2004-03-26 at 15:19, Oystein Haare wrote:
> > > On Fri, 2004-03-26 at 08:38, Benjamin Herrenschmidt wrote:
> > > > > > This is what it outputs:
> > 
> > Can you send me the full output from XFree too along with
> > you XF86Config file ?

Ok, it's getting the panel data from BIOS properly. Can you
try XFree "radeon" driver instead please ?

Ben.

