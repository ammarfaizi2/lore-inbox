Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265964AbUAUEip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUAUEgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:36:16 -0500
Received: from dp.samba.org ([66.70.73.150]:31457 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266054AbUAUEfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:35:53 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.1-mm4 
In-reply-to: Your message of "19 Jan 2004 13:40:56 BST."
             <p73r7xwglgn.fsf@verdi.suse.de> 
Date: Wed, 21 Jan 2004 15:06:57 +1100
Message-Id: <20040121043608.6E4BB2C0CB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <p73r7xwglgn.fsf@verdi.suse.de> you write:
> Rusty Russell <rusty@rustcorp.com.au> writes:
> 
> > Migrating to module_param() is the Right Thing here IMHO, which actually
> > takes the damn address,
> 
> The main problem is that module_parm renames the boot time arguments and
> makes them long and hard to remember.

Um, if the module name is neat, and the parameter name is neat, the
combination of the two with a "."  between them will be nest.

> E.g. the new argument needed to make the mouse work on KVMs is
> mindboogling, could be nearly a Windows registry entry.

I have no idea what you are talking about. 8(

Please explain,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
