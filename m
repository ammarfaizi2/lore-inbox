Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270240AbRHHAQ7>; Tue, 7 Aug 2001 20:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270242AbRHHAQu>; Tue, 7 Aug 2001 20:16:50 -0400
Received: from ip240.cvd2.rb1.bel.nwlink.com ([207.202.151.240]:33548 "EHLO
	zot.localdomain") by vger.kernel.org with ESMTP id <S270240AbRHHAQg>;
	Tue, 7 Aug 2001 20:16:36 -0400
To: Riley Williams <rhw@MemAlpha.CX>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <Pine.LNX.4.33.0108072359440.30936-100000@infradead.org>
From: Mark Atwood <mra@pobox.com>
Date: 07 Aug 2001 17:16:45 -0700
In-Reply-To: Riley Williams's message of "Wed, 8 Aug 2001 00:35:54 +0100 (BST)"
Message-ID: <m3bslrv21e.fsf@flash.localdomain>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(apologies for splitting my reply into multiple pieces, but each part
 covers different territory).

Riley Williams <rhw@MemAlpha.CX> writes:
> 
>  2. Multiple identical static interfaces.
> 
>     At the moment, you are required to initialise the interfaces in
>     ascending order of their name in the modules.conf file.
> 
>     I've dealt with this situation on several occasions, and never
>     found this to be a problem in any way.

Have you ever assembled a distribution that's going to be imaged into
several thousands to several tens of thousands of hardware boxes, with
evolving-into-the-future changes in hardware version and changes in
component suppliers?

If Linux really wants to break into the appliance market, this is
going to be a bigger and bigger issue.

-- 
Mark Atwood   | I'm wearing black only until I find something darker.
mra@pobox.com | http://www.pobox.com/~mra
