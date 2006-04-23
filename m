Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWDWT3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWDWT3v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 15:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWDWT3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 15:29:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47631 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751449AbWDWT3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 15:29:51 -0400
Date: Sun, 23 Apr 2006 21:29:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Fernando Barsoba <fbarsoba@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: installing older kernel (2.4.20/28 on machine running 2.6.15)
Message-ID: <20060423192949.GA13666@stusta.de>
References: <BAY114-F29C3E96DDE09CAFB6E7528C7B90@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY114-F29C3E96DDE09CAFB6E7528C7B90@phx.gbl>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2006 at 02:38:57PM -0400, Fernando Barsoba wrote:

> Hi,

Hi Fernando,

> Is it possible to install 2.4.28 on machine with 2.6.15? I am getting 
> contradictory statements regarding this issue, like it is not possible to 
> install an older version of kernel on machine running a much newer version. 
> Is that true?

it is possible since installing a kernel is independent of the currently 
running kernel.

The question is whether your userspace (IOW: your distribution) 
supports kernel 2.4.28.

> tnx,
> Fernando

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

