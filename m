Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTDOVkf (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264114AbTDOVkf 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:40:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10449 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264113AbTDOVkd (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 17:40:33 -0400
Date: Tue, 15 Apr 2003 23:52:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: depmod fails if kernel linked with ld 2.13
Message-ID: <20030415215218.GA1360@fs.tum.de>
References: <yw1xfzoujy4q.fsf@nogger.e.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xfzoujy4q.fsf@nogger.e.kth.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 02:22:13PM +0200, Måns Rullgård wrote:

> If the kernel is linked with ld from GNU binutils 2.13 depmod
> complains about lots of unresolved symbols.  Isn't it about time that
> this was fixed?

If you are thinking about .text.exit errors, they wouldn't occur at 
depmod.

Could you tell which kernel version and send the exact error message?

> Måns Rullgård

cu
Adrian

--

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

