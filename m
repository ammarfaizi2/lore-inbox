Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262579AbRE3CdB>; Tue, 29 May 2001 22:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbRE3Ccv>; Tue, 29 May 2001 22:32:51 -0400
Received: from femail14.sdc1.sfba.home.com ([24.0.95.141]:61344 "EHLO
	femail14.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262579AbRE3Cci>; Tue, 29 May 2001 22:32:38 -0400
Date: Tue, 29 May 2001 22:32:35 -0400
From: Tom Vier <tmv5@home.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac3: qlogic corruption on alpha
Message-ID: <20010529223235.C2090@zero>
In-Reply-To: <20010529210958.A821@zero> <3B145567.91C7A561@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B145567.91C7A561@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, May 29, 2001 at 10:05:27PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 10:05:27PM -0400, Jeff Garzik wrote:
> Also, what compiler are you using?  Depending on your current compiler,
> switching to another compiler according to one of the following
> permutations would be very instructive for us debugging the problem, at
> least.

debian 2.25.2 20000220

> 	gcc-2.96-RH -> gcc-2.95.3
> 	gcc-2.95.2 -> gcc-2.95.3
> 	gcc-2.95.3 -> egcs-1.1.2

i'll give another one a try, tomorrow.

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
