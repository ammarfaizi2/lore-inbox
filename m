Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262671AbTCIXtB>; Sun, 9 Mar 2003 18:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262672AbTCIXtB>; Sun, 9 Mar 2003 18:49:01 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:46231 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S262671AbTCIXs5>;
	Sun, 9 Mar 2003 18:48:57 -0500
Date: Mon, 10 Mar 2003 00:59:34 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: struct inode size reduction.
Message-ID: <20030309235934.GA3962@werewolf.able.es>
References: <20030309135402.GB32107@suse.de> <20030309224552.GA3047@werewolf.able.es> <20030310001129.GB13869@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030310001129.GB13869@suse.de>; from davej@codemonkey.org.uk on Mon, Mar 10, 2003 at 01:11:29 +0100
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.10, Dave Jones wrote:
> On Sun, Mar 09, 2003 at 11:45:52PM +0100, J.A. Magallon wrote:
> 
>  > If you do not need gcc-2.95 support, you can use anonymous unions:
>  > I have tested on gcc-3.0, 3.2.2, RH gcc-2.96-98, and 2.95.2. Only 2.95.2
>  > fails.
> 
> What about the magick ancient version that sparc uses 

That was my point, I do not know if some arch still requires 2.95 in 2.6.
For 2.4, it states 2.95.3 as minimun.

There is not anything newer for sparc ? Curious...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre5-jam0 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
