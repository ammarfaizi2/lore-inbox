Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263332AbSJWJfl>; Wed, 23 Oct 2002 05:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbSJWJeY>; Wed, 23 Oct 2002 05:34:24 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:41155 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S263246AbSJWJbp>;
	Wed, 23 Oct 2002 05:31:45 -0400
Date: Wed, 23 Oct 2002 11:37:54 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andi Kleen <ak@suse.de>
Cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: How to decode call trace
Message-ID: <20021023093754.GA28389@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, Andi Kleen <ak@suse.de>,
	Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
	linux-kernel@vger.kernel.org
References: <87elai82xb.fsf@goat.bogus.local.suse.lists.linux.kernel> <p73isztstim.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73isztstim.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 05:50:41AM +0200, Andi Kleen wrote:

> > Is there a way to get the line number out of these hex values?
> 
> addr2line -e vmlinux ... does this when you compile the kernel with -g 

Also interesting is http://ds9a.nl/symoops

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
