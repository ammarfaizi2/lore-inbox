Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTJAIKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJAIKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:10:39 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:20186 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S261305AbTJAIKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:10:38 -0400
Subject: Re: [PATCH] 2.6: joydev is too eager claiming input devices
From: Dan <overridex@punkass.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20030924232912.7e41d9f9.akpm@osdl.org>
References: <1064459037.19555.3.camel@nazgul.overridex.net>
	 <200309250012.48522.dtor_core@ameritech.net>
	 <20030924232912.7e41d9f9.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1064995829.14483.8.camel@nazgul.overridex.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 01 Oct 2003 04:10:29 -0400
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-25 at 02:29, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> > Could you please try the following patch (it is incremental against the 
> >  previous one and should apply to the -mm)
> 
> I ran that patch[1] past Vojtech yesterday and he then fixed the problem
> which it was addressing by other means within his tree.
> 
> So what we should do is to ask Vojtech to share that change with us so Dan
> can test it, please.
> 
> 
> [1] ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm4/broken-out/joydev-exclusions.patch
> 

Hi again,

I'm using 2.6.0-test6 right now with Dmitry's fix and it works fine,
still waiting for Vojtech's code to test out -Dan


