Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310417AbSCPQGd>; Sat, 16 Mar 2002 11:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310423AbSCPQGX>; Sat, 16 Mar 2002 11:06:23 -0500
Received: from ns.suse.de ([213.95.15.193]:30474 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310417AbSCPQGS>;
	Sat, 16 Mar 2002 11:06:18 -0500
Date: Sat, 16 Mar 2002 17:06:17 +0100
From: Dave Jones <davej@suse.de>
To: Georg Nikodym <georgn@somanetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MCE hangs on 2.4.19-pre3-rmap12g
Message-ID: <20020316170617.A15296@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Georg Nikodym <georgn@somanetworks.com>, linux-kernel@vger.kernel.org
In-Reply-To: <15507.22980.217699.244120@somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15507.22980.217699.244120@somanetworks.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 09:42:12AM -0500, Georg Nikodym wrote:
 > Both laptops hang very early in the boot process after emitting the
 > message:
 > 
 >     Intel machine check architecture supported

 Read the archives. This bug has been discussed to death already,
 and there have been at least half a dozen postings of patches.
 (hint: drop the bluesmoke.c changes from pre3)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
