Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbRFVFYz>; Fri, 22 Jun 2001 01:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265338AbRFVFYp>; Fri, 22 Jun 2001 01:24:45 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15552 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265337AbRFVFYl>;
	Fri, 22 Jun 2001 01:24:41 -0400
Message-ID: <3B32D694.CACF46D0@mandrakesoft.com>
Date: Fri, 22 Jun 2001 01:24:36 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>
Subject: Re: PATCH: ethtool MII helpers
In-Reply-To: <3B23AFC3.71CE2FD2@mandrakesoft.com> <20010622171037.D2576@metastasis.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> Can we
> not extend ethtool for the mii-tool stuff, even if only at userland?

Sure, and that's planned.  Wanna send me a patch for it?  :)

It will definitely fall back on the MII ioctls if ethtool media support
for the desired command doesn't exist.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
