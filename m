Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRGONMo>; Sun, 15 Jul 2001 09:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266464AbRGONMe>; Sun, 15 Jul 2001 09:12:34 -0400
Received: from weta.f00f.org ([203.167.249.89]:61571 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266448AbRGONMW>;
	Sun, 15 Jul 2001 09:12:22 -0400
Date: Mon, 16 Jul 2001 01:12:27 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __KERNEL__ removal
Message-ID: <20010716011227.B10493@weta.f00f.org>
In-Reply-To: <E15LTIY-0001Ul-00@the-village.bc.nu> <3B5083AE.71515696@mandrakesoft.com> <p05100309b77639cfaced@[207.213.214.37]> <3B508D34.180A07A0@mandrakesoft.com> <84uhW6amw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84uhW6amw-B@khms.westfalen.de>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 01:53:00PM +0200, Kai Henningsen wrote:

    ... but if we are looking for a clean solution to types and
    constants that are needed to communicate between kernel and user
    space, IMO the thing to do is to define these in some sort of
    generic format, and have a tool to generate actual headers from
    that according to whatever kernel, libc or whoever wants to
    see. Possibly more than one tool as requirements differ.

Too complex, too hard... why not standard headers for the kernel
peoplem as that is the origin on the headers and helper comments for
others?


  --cw
