Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271846AbRHVCju>; Tue, 21 Aug 2001 22:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271917AbRHVCjb>; Tue, 21 Aug 2001 22:39:31 -0400
Received: from sub.sonic.net ([208.201.224.8]:11828 "EHLO sub.sonic.net")
	by vger.kernel.org with ESMTP id <S271846AbRHVCjX>;
	Tue, 21 Aug 2001 22:39:23 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 21 Aug 2001 19:39:37 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.9 build fails on Mandrake 8.0 ( make modules_install 'isdn')
Message-ID: <20010821193937.A26871@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010821092020.B968@thune.mrc-home.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2001 at 09:20:20AM -0700, Mike Castle wrote:
> On Tue, Aug 21, 2001 at 05:47:01PM +0200, Kai Germaschewski wrote:
> > Well, I said should ;-) Maybe I should have tried...
> > 
> > Next try: (still untested)
> 
> Closer.
> 
> Had to add #include <linux/types.h> to the header file too.


That finally worked.

Yay.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
