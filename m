Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271018AbRHTC2x>; Sun, 19 Aug 2001 22:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271015AbRHTC2n>; Sun, 19 Aug 2001 22:28:43 -0400
Received: from buzz.sonic.net ([208.201.224.78]:42764 "EHLO buzz.sonic.net")
	by vger.kernel.org with ESMTP id <S271005AbRHTC23>;
	Sun, 19 Aug 2001 22:28:29 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sun, 19 Aug 2001 19:28:32 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Mike Castle <dalgoda@ix.netcom.com>, mayfield+usb@sackheads.org
Subject: Re: [PATCH] config options for USB
Message-ID: <20010819192832.I30309@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	mayfield+usb@sackheads.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010819153017.A24976@one-eyed-alien.net>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2001 at 03:30:17PM -0700, Matthew Dharm wrote:
> These two should probably be put under "experimental".
> 
> On Sun, Aug 19, 2001 at 12:44:59PM -0700, Mike Castle wrote:
> > I noticed that 2.4.8 introduced Jimme Mayfield's Datafab and Jumpshot USB
> > drivers.  However, there are no entries in Config.in.  There were also


What about the rest of the new storage support that doesn't have entries.
Could you produce the necessary Config.in entries for those as well?  Or at
least enumerate them.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
