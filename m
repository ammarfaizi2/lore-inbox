Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131512AbRCWXa0>; Fri, 23 Mar 2001 18:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbRCWXaQ>; Fri, 23 Mar 2001 18:30:16 -0500
Received: from [195.63.194.11] ([195.63.194.11]:31237 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131512AbRCWXaD>; Fri, 23 Mar 2001 18:30:03 -0500
Message-ID: <3ABBD974.C41B70CD@evision-ventures.com>
Date: Sat, 24 Mar 2001 00:17:08 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <UTC200103232315.AAA07966.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> [to various people]
> 
> No, ulimit does not work. (But it helps a little.)
> No, /proc/sys/vm/overcommit_memory does not work.
> 
> [to Alan]
> 
> > Nobody feels its very important because nobody has implemented it.
> 
> Yes, that is the right response.
> What can one say? One can only do.

Please just expect a patch for tomorrow ;-).

The only thing I have currently to do is testing.
I will be using the installation process of the ORACLE iAS 9i for
linux on my notebook, becouse it used to trigger oom for me VERY
frequently. So far all things BEHAVE...
