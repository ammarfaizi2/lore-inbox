Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTESSc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTESSc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:32:58 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:8713 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S262710AbTESSc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:32:57 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.5.69-bk1[23] kconfig loop
Date: Mon, 19 May 2003 18:45:55 +0000 (UTC)
Organization: Cistron
Message-ID: <bab8p3$qt8$1@news.cistron.nl>
References: <200305191821.h4JILlE12026@adam.yggdrasil.com>
X-Trace: ncc1701.cistron.net 1053369955 27560 62.216.30.38 (19 May 2003 18:45:55 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter <adam@yggdrasil.com> wrote:
>If I run "make oldconfig" under linux-2.5.69-bk12
>and select "m" for CONFIG_USB_GADGET, I am asked a question
>or two about USB gadget interfaces that I might want, and
>then the build process gets into an infinite loop.  If I set
>CONFIG_USB_GADGET to "n", then everything is fine.

Same for -mm6 & -mm7 ;-)

Danny

-- 
Miguel   | "I can't tell if I have worked all my life or if
de Icaza |  I have never worked a single day of my life,"

