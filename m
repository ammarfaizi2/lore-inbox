Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263129AbTC1UQ4>; Fri, 28 Mar 2003 15:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263130AbTC1UQ4>; Fri, 28 Mar 2003 15:16:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:8410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263129AbTC1UQz>;
	Fri, 28 Mar 2003 15:16:55 -0500
Date: Fri, 28 Mar 2003 12:23:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any resolution of keyboard problems?
Message-Id: <20030328122349.55f76130.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0303281501240.24496-100000@dell>
References: <Pine.LNX.4.44.0303281501240.24496-100000@dell>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003 15:03:06 -0500 (EST) "Robert P. J. Day" <rpjday@mindspring.com> wrote:

|   i just downloaded the bk4 set of patches for 2.5.66 to see if
| anything has changed with respect to the weird keyboard problems
| i was having with my dell laptop and its external PS/2 keyboard.
| 
|   has anyone else been seeing this?  do any of the patches
| in the bk4 snapshot address this?  i'm recompiling as we speak,
| and i'll test it again as soon as i can.

I looked at the config file that you posted and didn't see
any glaring issues with it, but then I don't have a Dell laptop
either.

You might have to find an earlier kernel that works and then
find where it breaks.  Or turn off some big things, like APM
(just for testing).

--
~Randy
