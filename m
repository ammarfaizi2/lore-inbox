Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132531AbRCZSLF>; Mon, 26 Mar 2001 13:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132528AbRCZSKy>; Mon, 26 Mar 2001 13:10:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52740 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132505AbRCZSKn>;
	Mon, 26 Mar 2001 13:10:43 -0500
Date: Mon, 26 Mar 2001 19:09:45 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Matthew Wilcox <matthew@wil.cx>, LA Walsh <law@sgi.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
Message-ID: <20010326190945.I31126@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20010326181803.F31126@parcelfarce.linux.theplanet.co.uk> <200103261747.f2QHlEX19564@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103261747.f2QHlEX19564@webber.adilger.int>; from adilger@turbolinux.com on Mon, Mar 26, 2001 at 10:47:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 10:47:13AM -0700, Andreas Dilger wrote:
> What do you mean by problems 5 years down the road?  The real issue is that
> this 32-bit block count limit affects composite devices like MD RAID and
> LVM today, not just individual disks.  There have been several postings
> I have seen with people having a problem _today_ with a 2TB limit on
> devices.

people who can afford 2TB of disc can afford to buy a 64-bit processor.

-- 
Revolutions do not require corporate support.
