Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVCZTN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVCZTN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 14:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVCZTN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 14:13:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56581 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261262AbVCZTNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 14:13:11 -0500
Date: Sat, 26 Mar 2005 20:13:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Dyck <david.dyck@fluke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols still in 2.4.30-rc2 (usbserial needs symbol tty_ldisc_ref and tty_ldisc_deref which are EXPORT_SYMBOL_GPL)
Message-ID: <20050326191306.GE3237@stusta.de>
References: <Pine.LNX.4.62.0503261052050.1495@dd.tc.fluke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503261052050.1495@dd.tc.fluke.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 10:52:30AM -0800, David Dyck wrote:
> 
> I've been noticing that I'm still getting some "unresolved symbols"
> with the 2.4.30 pre and rc series.
>...
> ver_linux reports:
>...
> modutils               2.4.2
>...

A modutils upgrade should fix your problems.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

