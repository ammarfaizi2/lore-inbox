Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSGZETu>; Fri, 26 Jul 2002 00:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSGZETu>; Fri, 26 Jul 2002 00:19:50 -0400
Received: from rj.SGI.COM ([192.82.208.96]:34481 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S316757AbSGZETu>;
	Fri, 26 Jul 2002 00:19:50 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] new module interface 
In-reply-to: Your message of "Fri, 26 Jul 2002 13:43:39 +1000."
             <20020726034921.368CE4575@lists.samba.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jul 2002 14:22:53 +1000
Message-ID: <8643.1027657373@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002 13:43:39 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>I need that too: the mythical "KBUILD_MODNAME".  Both Keith and Kai
>promised it to me...

KBUILD_OBJECT has been in kbuild 2.5 since April 5 (kbuild-2.5-core-1).
It is not my fault if Linus won't take it and Kai will not implement
it.

