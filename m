Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132909AbREBMjZ>; Wed, 2 May 2001 08:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132914AbREBMjO>; Wed, 2 May 2001 08:39:14 -0400
Received: from www.linux.org.uk ([195.92.249.252]:30481 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S132909AbREBMjD>;
	Wed, 2 May 2001 08:39:03 -0400
Date: Wed, 2 May 2001 13:38:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Feng Xian <fxian@fxian.jukie.net>
Cc: "Sim, CT (Chee Tong)" <CheeTong.Sim@sin.rabobank.com>,
        "'Michel Wilson'" <michel@procyon14.yi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux NAT questions- (kernel upgrade??)
Message-ID: <20010502133823.A5778@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	Feng Xian <fxian@fxian.jukie.net>,
	"Sim, CT (Chee Tong)" <CheeTong.Sim@sin.rabobank.com>,
	'Michel Wilson' <michel@procyon14.yi.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1E8992B3CD28D4119D5B00508B08EC5627E8A4@sinxsn02.ap.rabobank.com> <Pine.LNX.4.33.0105020821480.1388-100000@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0105020821480.1388-100000@tiger>; from fxian@fxian.jukie.net on Wed, May 02, 2001 at 08:22:54AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2001 at 08:22:54AM -0400, Feng Xian wrote:
> i think iptables is a new feature in kernel 2.4.x(and you have to build
> it in the kernel or as module). you can use ipchains if
> you are running kernel with lower version, 2.2.something.

I think you'll find that 2.4 is compatible with ipchains, as long as
you load the relevent module/configure the kernel right.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

