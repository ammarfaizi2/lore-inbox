Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317139AbSFFSyG>; Thu, 6 Jun 2002 14:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSFFSyB>; Thu, 6 Jun 2002 14:54:01 -0400
Received: from ns.suse.de ([213.95.15.193]:53778 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317139AbSFFSxw>;
	Thu, 6 Jun 2002 14:53:52 -0400
Date: Thu, 6 Jun 2002 20:53:52 +0200
From: Dave Jones <davej@suse.de>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] dd, floppy, 2.5.18
Message-ID: <20020606205352.C16262@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Stuart MacDonald <stuartm@connecttech.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <02aa01c20d86$ae9e8bc0$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 02:19:22PM -0400, Stuart MacDonald wrote:
 > I'm willing to help with some testing to figure out the problem; I use
 > this dd method to make diskette images for customers all the time, and
 > I will need it fixed for 2.6.x.

There's a patch included in 2.5.20-dj3 from Mikael Pettersson,
which should address the corruption on IO problem.
You can also fish out the individual patch at..
http://www.codemonkey.org.uk/patches/merged/2.5.20/dj3/

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
