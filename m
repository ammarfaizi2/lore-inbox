Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTJSLVu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 07:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTJSLVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 07:21:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19658 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261970AbTJSLVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 07:21:49 -0400
Date: Sun, 19 Oct 2003 13:21:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, action list
Message-ID: <20031019112141.GN12423@fs.tum.de>
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <20031014214311.GC933@inwind.it> <16710000.1066170641@flay> <20031014155638.7db76874.cliffw@osdl.org> <20031015124842.GE20846@lug-owl.de> <20031015131015.GR16158@holomorphy.com> <20031015150530.GJ20846@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015150530.GJ20846@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 05:05:30PM +0200, Jan-Benedict Glaw wrote:
>...
> locked xchgs. If glibc/libstdc++ would go back, ABI would break and you
> couldn't any longer copy programs build within one distribution over to
> another.
>...

It's only libstdc++, and the libstdc++ ABI will change again in the 
forseeable future.

> MfG, JBG

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

