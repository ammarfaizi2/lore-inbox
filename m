Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266365AbUHNKfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUHNKfH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 06:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUHNKfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 06:35:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19081 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266357AbUHNKe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 06:34:58 -0400
Message-ID: <411DEAC2.7050105@pobox.com>
Date: Sat, 14 Aug 2004 06:34:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <20040814101039.GA27163@alpha.home.local>
In-Reply-To: <20040814101039.GA27163@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi Linus & All,
> 
> I've just compiled and booted 2.6.8 on my dual athlon. Everything went
> OK before I logged in as a non-root user whose home is mounted from
> another linux box over NFSv3/UDP.
> 
> I got this oops :

Already solved in another thread...

http://marc.theaimsgroup.com/?l=linux-kernel&m=109247958302409&w=2

