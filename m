Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTEMP4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTEMPzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:55:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31387
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261369AbTEMPyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:54:18 -0400
Subject: Re: ARM26 [NEW ARCHITECTURE]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ian Molton <spyro@f2s.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030513163001.3a80f822.spyro@f2s.com>
References: <20030513153315.73679a38.spyro@f2s.com>
	 <1052835818.431.37.camel@dhcp22.swansea.linux.org.uk>
	 <20030513163001.3a80f822.spyro@f2s.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052838520.463.43.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 May 2003 16:08:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-13 at 16:30, Ian Molton wrote:
> it is 2.5 targetted currently 2.5.30, but the arch/ and asm/ stuff is
> independant as far as the rest of the tree is concerned, so it may as
> well go in as 'current' and then I can submit smaller patches to 'catch
> up' with the rest.
> 
> it actually compiles on 2.5.30 (at least, some of it does ;-) and runs,
> excpet so far, mm stuff fails and user-land falls over HARD ver early.
> 
> where do I send my patches? ;-)

I'll roll the include/asm and arch/arm26 bits into -ac happily, if only so
they are seen for criticism. (Read hch filling your mailbox 8))

