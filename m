Return-Path: <linux-kernel-owner+w=401wt.eu-S932090AbWLNI47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWLNI47 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWLNI47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:56:59 -0500
Received: from postfix2-g20.free.fr ([212.27.60.43]:36478 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbWLNI46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:56:58 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 03:56:58 EST
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Date: Thu, 14 Dec 2006 09:49:43 +0100
User-Agent: KMail/1.9.5
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20061213195226.GA6736@kroah.com> <20061213203113.GA9026@suse.de> <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612140949.43270.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm really not convinced about the user-mode thing unless somebody can 
> show me a good reason for it. Not just some "wouldn't it be nice" kind of 
> thing. A real, honest-to-goodness reason that we actually _want_ to see 
> used.

Qemu?  It would be nice if emulators could directly drive hardware:
useful for reverse engineering windows drivers for example.

Duncan.
