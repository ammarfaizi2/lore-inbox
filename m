Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbSL3NXJ>; Mon, 30 Dec 2002 08:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbSL3NXJ>; Mon, 30 Dec 2002 08:23:09 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:12021 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266962AbSL3NXI>; Mon, 30 Dec 2002 08:23:08 -0500
Subject: Re: Current unclaimed 2.5 bugs on bugme.osdl.org
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: kernel-janitors@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <129460000.1041214462@titus>
References: <129460000.1041214462@titus>
Content-Type: text/plain
Organization: 
Message-Id: <1041255152.544.14.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 30 Dec 2002 14:32:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 03:14, Martin J. Bligh wrote:

> ID Sev Owner State Result Summary
> 44 blo khoa@us.ibm.com OPEN radeonfb does not compile at all - seems 
> incomplete? or w...

Beeing worked on by James Simmons and myself. Working version in the PPC
tree, will be part of next round of fbdev updates

> 69 nor mbligh@aracnet.com OPEN Framebuffer bug
> 72 nor khoa@us.ibm.com OPEN Framebuffer scrolls at the wrong times/places
> 79 nor khoa@us.ibm.com OPEN Framebuffer scrolling problem

I've seen at least some of these discussed on the linux-fbdev mailing
list, though I can't talk for the maintainer, I beleive they are beeing
worked on.

> 117 nor mbligh@aracnet.com OPEN build failure: arch/ppc/kernel/process.c

Works in current ppc bk tree, probably waiting for next round of merges
by Paul Mackerras to Linus.

> -- 
> Benjamin Herrenschmidt <benh@kernel.crashing.org>

