Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSGHXwe>; Mon, 8 Jul 2002 19:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSGHXwd>; Mon, 8 Jul 2002 19:52:33 -0400
Received: from ns1.ptt.yu ([212.62.32.1]:56965 "EHLO ns1.ptt.yu")
	by vger.kernel.org with ESMTP id <S317264AbSGHXwc>;
	Mon, 8 Jul 2002 19:52:32 -0400
Subject: Re: system call
From: Vladimir Zidar <vladimir@mindnever.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0207080808310.7622-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0207080808310.7622-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 09 Jul 2002 01:59:42 +0200
Message-Id: <1026172783.2084.26.camel@server1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-08 at 17:16, Randy.Dunlap wrote:


>   http://www.xenotime.net/linux/syscall_ex/
> contains a howto, kernel patch, and test program.

 And how to choose goot syscall number ? Are some numbers pre-reserved
to 'private' syscalls ? What numbers are free to use, without fear that
new kernel release will just jump over them !?
 And what about an idea to be able to add syscall by name, from loadab;e
module of course.  Userland application will then resolve 'name' to
number at startup, and use it just as ordinary syscall ?


-- 
Bye,

 and have a very nice day !



