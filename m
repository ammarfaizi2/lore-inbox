Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWIHW4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWIHW4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWIHW4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:56:40 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:38313 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751250AbWIHW4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:56:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1
Date: Sat, 9 Sep 2006 00:57:48 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0609081636310.7953-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609081636310.7953-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609090057.49518.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 8 September 2006 22:44, Alan Stern wrote:
> On Fri, 8 Sep 2006, Andrew Morton wrote:
> 
> > Alan, is this likely to be due to your USB PM changes?
> 
> It's possible.  Most of those changes are innocuous.  They add routines
> that don't get used until a later patch.  However one of them might be
> responsible.

Well, after recompiling the kernel for several times (because of a different
problem) I'm no longer able to reproduce the problem.

Sorry for the noise.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
