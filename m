Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUJNTDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUJNTDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267353AbUJNTDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:03:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:23241 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267345AbUJNTBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:01:16 -0400
Date: Thu, 14 Oct 2004 21:01:08 +0200
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4-mm1 OOPs on AMD64
Message-ID: <20041014190108.GE7973@wotan.suse.de>
References: <1097527401.12861.383.camel@dyn318077bld.beaverton.ibm.com> <20041011214304.GD31731@wotan.suse.de> <1097532118.12861.395.camel@dyn318077bld.beaverton.ibm.com> <20041011221519.GA11702@wotan.suse.de> <20041011153830.495b7c2d.akpm@osdl.org> <1097779232.2861.9.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097779232.2861.9.camel@dyn318077bld.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I will leave it capable hands of Andi to figure out whats wrong
> with it. Andi, if you want me to test the fix, send it my way.

Oops. Weird, it worked on my machines.

Sorry for the problems and thanks for tracking it down
I will look at it.  Andrew, probably just back it out for now.

Badari, Can you send me the beginning of your boot.msg again so that
I can see your node layout?  (you probably did already, but I cannot
find the mail anymore) 

-Andi
