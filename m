Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310539AbSCLKDB>; Tue, 12 Mar 2002 05:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310540AbSCLKCq>; Tue, 12 Mar 2002 05:02:46 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:30958 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S310539AbSCLKCj>; Tue, 12 Mar 2002 05:02:39 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1015895241.928.107.camel@phantasy> 
In-Reply-To: <1015895241.928.107.camel@phantasy>  <200203120100.RAA00468@marcy.nas.nasa.gov> 
To: Robert Love <rml@tech9.net>
Cc: Brian S Queen <bqueen@nas.nasa.gov>, linux-kernel@vger.kernel.org
Subject: Re: Upgrading Headers? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Mar 2002 10:02:27 +0000
Message-ID: <6468.1015927347@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rml@tech9.net said:
>  You don't.  The headers in /usr/include/linux and /usr/include/asm
> (which may be a symlink to /usr/src/linux/include/linux and /usr/src/
> linux/include/asm, respectively) should point to the kernel headers
> that were present when _glibc_ was compiled. 

No it may not be a symlink. That would be broken.

--
dwmw2


