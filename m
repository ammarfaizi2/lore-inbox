Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271774AbRHUSJk>; Tue, 21 Aug 2001 14:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271772AbRHUSJa>; Tue, 21 Aug 2001 14:09:30 -0400
Received: from ultra.sonic.net ([208.201.224.22]:62800 "EHLO ultra.sonic.net")
	by vger.kernel.org with ESMTP id <S271775AbRHUSJM>;
	Tue, 21 Aug 2001 14:09:12 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 21 Aug 2001 11:09:25 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Cc: Mike Castle <dalgoda@ix.netcom.com>
Subject: Re: Kernel 2.4.9 build fails on Mandrake 8.0 ( make modules_install 'isdn')
Message-ID: <20010821110925.A26851@thune.mrc-home.com>
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
> Closer.
> 
> Had to add #include <linux/types.h> to the header file too.


Still compiling (only a P5/233).  But looks promising.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
