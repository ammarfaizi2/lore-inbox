Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTJ0BiS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 20:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTJ0BiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 20:38:18 -0500
Received: from razorbill.mail.pas.earthlink.net ([207.217.121.248]:63907 "EHLO
	razorbill.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263269AbTJ0BiQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 20:38:16 -0500
From: Guy <fsos_guy@earthlink.net>
Organization: C
To: <wsy@merl.com>
Subject: Re: compile-time error in 2.6.0-test9
Date: Sun, 26 Oct 2003 21:26:15 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200310261553.h9QFrb513039@localhost.localdomain> <3F9C5DEC.2080006@greenhydrant.com> <200310270009.h9R09QW13930@localhost.localdomain>
In-Reply-To: <200310270009.h9R09QW13930@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310262126.20844.fsos_guy@earthlink.net>
X-ELNK-Trace: d501ffacebf681585e89bb4777695beb702e37df12b9c9ef46918407404fe803bb1d21b95eb7462a350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 October 2003 19:09, wsy@merl.com wrote:
>    From: David Rees <drees@greenhydrant.com>
>
>    wsy@merl.com wrote:
>    > Now, to figure out why I've got a bunch of unresolved
>    > symbols in when I do "make modules_install".
>
>    You need an updated modutils package.  See the modules
> section in this document:
> http://www.codemonkey.org.uk/post-halloween-2.5.txt
>
> OK, that leads to
> kernel.org/pub/linux/kernel/people/rusty/modules/, I'll grab
> the modutils src rpm there and build it.
>
> Thanks!
>
> 	-Bill Yerazunis

I Am Not A Programmer:

Having said that, I do install and run bleeding edge Gentoo. 
gcc-3.3.1 has been rock solid for me. I've not had any of my 
kernel compiles barf on my machines for quite some time. I 
usually have the latest kernel installed and running within 2 
days of it's release. I think I'm addicted. ;-)

I use both the -O3 and -Os options depending on target machine.

Guy

-- 
Recyle computers. Install Gentoo GNU/Linux.

