Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313559AbSDZAYr>; Thu, 25 Apr 2002 20:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313560AbSDZAYq>; Thu, 25 Apr 2002 20:24:46 -0400
Received: from ns.suse.de ([213.95.15.193]:36622 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313559AbSDZAYq>;
	Thu, 25 Apr 2002 20:24:46 -0400
Date: Fri, 26 Apr 2002 02:24:45 +0200
From: Dave Jones <davej@suse.de>
To: dmacbanay@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.10 problems
Message-ID: <20020426022445.O14343@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, dmacbanay@softhome.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <courier.3CC89816.00006EFA@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 05:58:14PM -0600, dmacbanay@softhome.net wrote:

 > 3.  Starting sometime after kernel 2.5.1 (I couldn't compile any kernels 
 > from then up until 2.5.5) the Evolution email program locks up whenever 
 > Calender, Tasks, or Contacts is selected.  I have to go to another terminal 
 > and kill it. 

Oh, and does this still apply to 2.5.10 ?
Again, last few lines from an strace to find out what its doing when it locks
up may be useful.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
