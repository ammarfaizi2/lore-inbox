Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUKLSnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUKLSnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 13:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUKLSnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 13:43:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13575 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262605AbUKLSnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 13:43:12 -0500
Date: Fri, 12 Nov 2004 19:42:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jurriaan <thunder7@xs4all.nl>
Cc: Libor Vanek <libor@conet.cz>, linux-kernel@vger.kernel.org
Subject: Re: Highmem fails to compile with 2.6.10-rc1-mm5
Message-ID: <20041112184241.GI2249@stusta.de>
References: <4194C9A3.6080106@conet.cz> <20041112165810.GA28664@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112165810.GA28664@middle.of.nowhere>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 05:58:10PM +0100, Jurriaan wrote:
>...
> Also, to prevent needlessly large messages, could you filter out all the
> 'is not set' lines when posting your .config? They are not necessary for
> anybody. Just grep "=" /usr/src/linux-x.x.xx/.config and you'll save
> lots of bandwidth.

Please don't do this.

People who care about bandwith sholdn't subscribe to linux-kernel, and 
in my experience it is much easier to reproduce a compile error if you 
have a complete .config (yes it's still possible otherwise, but it's 
more work during "make oldconfig").

> Kind regards,
> Jurriaan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

