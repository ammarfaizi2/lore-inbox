Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283286AbSADSVQ>; Fri, 4 Jan 2002 13:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282690AbSADSVB>; Fri, 4 Jan 2002 13:21:01 -0500
Received: from t2.redhat.com ([199.183.24.243]:497 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S282400AbSADSUj>; Fri, 4 Jan 2002 13:20:39 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0201041916490.20620-100000@Appserv.suse.de> 
In-Reply-To: <Pine.LNX.4.33.0201041916490.20620-100000@Appserv.suse.de> 
To: Dave Jones <davej@suse.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 Jan 2002 18:20:05 +0000
Message-ID: <20922.1010168405@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davej@suse.de said:
>  I doubt you'd need it in that many places. A few well chosen ones
> should probably suffice. 

Just putting it asm-*/types.h should just about be enough.

--
dwmw2


