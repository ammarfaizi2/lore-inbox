Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315212AbSEKWcY>; Sat, 11 May 2002 18:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316275AbSEKWcX>; Sat, 11 May 2002 18:32:23 -0400
Received: from ns.suse.de ([213.95.15.193]:59408 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315212AbSEKWcW>;
	Sat, 11 May 2002 18:32:22 -0400
Date: Sun, 12 May 2002 00:32:22 +0200
From: Dave Jones <davej@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        mochel@osdl.org, linux-kernel@vger.kernel.org, gone@us.ibm.com
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.15
Message-ID: <20020512003222.E30904@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	mochel@osdl.org, linux-kernel@vger.kernel.org, gone@us.ibm.com
In-Reply-To: <200205112206.g4BM6Dp13365@localhost.localdomain> <20020512001447.D30904@suse.de> <20020511222853.GD32767@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 03:28:53PM -0700, William Lee Irwin III wrote:
 > On Sun, May 12, 2002 at 12:14:47AM +0200, Dave Jones wrote:
 > > Other than Patricks work, and yours, the only other bits that are poking
 > > arch/i386 anytime soon are probably ACPI and possibly some further
 > > splitting up by one of the IBM folks whose name I've currently forgotten.
 > Patricia Gaughen (specifically for support of the NUMA-Q platform/subarch)

Ah, yes. Thanks for jogging my memory 8-)

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
