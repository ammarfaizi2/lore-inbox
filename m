Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbTAJJCh>; Fri, 10 Jan 2003 04:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbTAJJBg>; Fri, 10 Jan 2003 04:01:36 -0500
Received: from dp.samba.org ([66.70.73.150]:44190 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264697AbTAJJB3>;
	Fri, 10 Jan 2003 04:01:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PREFIX is non-empty 
In-reply-to: Your message of "Thu, 09 Jan 2003 18:49:23 +0900."
             <20030109094923.46A933745@mcspd15.ucom.lsi.nec.co.jp> 
Date: Fri, 10 Jan 2003 19:31:21 +1100
Message-Id: <20030110091013.E07DE2C46D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030109094923.46A933745@mcspd15.ucom.lsi.nec.co.jp> you write:
> Since these are just symbols in the module object, they need symbol name
> munging to find the symbol from the parameter name.

I've got this one already pending (I managed to pick up mail once
while travelling to a funeral, but generally I've been offline for 4
days).

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
