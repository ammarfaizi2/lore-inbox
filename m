Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264964AbSKGJaQ>; Thu, 7 Nov 2002 04:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSKGJaQ>; Thu, 7 Nov 2002 04:30:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44042 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264964AbSKGJaQ>; Thu, 7 Nov 2002 04:30:16 -0500
Date: Thu, 7 Nov 2002 09:36:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Jens Axboe <axboe@suse.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PATCH] Fix typo in sl82c105.c driver
Message-ID: <20021107093638.A7579@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Jens Axboe <axboe@suse.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, benh@kernel.crashing.org
References: <15817.54799.955377.260781@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15817.54799.955377.260781@argo.ozlabs.ibm.com>; from paulus@samba.org on Thu, Nov 07, 2002 at 01:55:11PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 01:55:11PM +1100, Paul Mackerras wrote:
> This patch fixes a minor typo in sl82c105.c which stops it from
> compiling.

Grr.  It needs _fixing_ first.  I haven't managed to get around to fixing
this mess that was created when Martin's stuff got ripped out.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

