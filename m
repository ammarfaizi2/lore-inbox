Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSDZAVl>; Thu, 25 Apr 2002 20:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313559AbSDZAVk>; Thu, 25 Apr 2002 20:21:40 -0400
Received: from ns.suse.de ([213.95.15.193]:53005 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313558AbSDZAVk>;
	Thu, 25 Apr 2002 20:21:40 -0400
Date: Fri, 26 Apr 2002 02:21:39 +0200
From: Dave Jones <davej@suse.de>
To: dmacbanay@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.10 problems
Message-ID: <20020426022139.N14343@suse.de>
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

 > 4.  Starting with kernel 2.5.6 (kernels 2.5.5 through 2.5.6-pre3 work)  the 
 > KDE program krecord closes right after it starts. 

Interesting. last few lines of strace output may show up what's going on.
Can you do a before/after strace on a working & non-working kernel?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
