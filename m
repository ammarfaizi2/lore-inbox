Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293760AbSB1VPG>; Thu, 28 Feb 2002 16:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310115AbSB1VMv>; Thu, 28 Feb 2002 16:12:51 -0500
Received: from ns.suse.de ([213.95.15.193]:17924 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310114AbSB1VLy>;
	Thu, 28 Feb 2002 16:11:54 -0500
Date: Thu, 28 Feb 2002 22:11:52 +0100
From: Dave Jones <davej@suse.de>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tdfx ported to new fbdev api
Message-ID: <20020228221152.K32662@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Simmons <jsimmons@transvirtual.com>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020228214045.E32662@suse.de> <Pine.LNX.4.10.10202281242570.20040-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202281242570.20040-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Thu, Feb 28, 2002 at 12:44:26PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 12:44:26PM -0800, James Simmons wrote:
 > Their are a few changes. I tested it last night and it worked for me. That
 > doesn't mean much so if you could give it a try. BTW the penguin will not
 > show up. I need to expand the imageblit function but it is not top
 > priority right now.

 Now that you mention the penguin, I was reminded of something.
 Normally with this box, when the fb starts, the top 3rd of the
 screen has a large white rectangle blitted onto it for reasons
 I never figured out. Its purely cosmetic (it disappears when scrolling
 begins), so it wasn't something I really bothered investigating.

 It could be that with your reworking, this bug has taken on
 a new form, and is now doing something more dramatic.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
