Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132726AbRDNCak>; Fri, 13 Apr 2001 22:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132717AbRDNCab>; Fri, 13 Apr 2001 22:30:31 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9405 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S132722AbRDNCaU>;
	Fri, 13 Apr 2001 22:30:20 -0400
Message-ID: <3AD7B619.D1A812CC@mandrakesoft.com>
Date: Fri, 13 Apr 2001 22:29:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-17mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.0.0 doesn't remember configuration changes
In-Reply-To: <20010411191940.A9081@thyrsus.com> <E14nU6n-0007po-00@the-village.bc.nu> <20010411204523.C9081@thyrsus.com> <002701c0c2f1$fc672960$0201a8c0@home> <20010411225055.A11009@thyrsus.com> <003c01c0c312$73713300$0201a8c0@home> <20010411220646.A12550@thyrsus.com> <20010412232021.A682@nightmaster.csn.tu-chemnitz.de> <20010413221102.C4651@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> OK, 1.1.0 will do these things.  I'm still not certain I have `make
> oldconfig' right, but I trust someone will club me gently over the
> head if it's still not up to spec.

Yep :)   'vi .config' + 'make oldconfig' is the most efficient way to
update your kernel config, if you really know what you are doing.

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
