Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291238AbSAaTKx>; Thu, 31 Jan 2002 14:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291237AbSAaTKl>; Thu, 31 Jan 2002 14:10:41 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45444 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291236AbSAaTK0>;
	Thu, 31 Jan 2002 14:10:26 -0500
Date: Thu, 31 Jan 2002 14:10:25 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Bruce Harada <harada@mbr.sphere.ne.jp>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Misc ICH ID changes - revised
Message-ID: <20020131141025.E669@havoc.gtf.org>
In-Reply-To: <20020131224122.59d1de9e.bruce@ask.ne.jp> <E16WIFn-0002Iy-00@the-village.bc.nu> <20020201022958.7b58493f.harada@mbr.sphere.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201022958.7b58493f.harada@mbr.sphere.ne.jp>; from harada@mbr.sphere.ne.jp on Fri, Feb 01, 2002 at 02:29:58AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 02:29:58AM +0900, Bruce Harada wrote:
> 
> Sorry, I could have put that better... all I was talking about there was
> renaming the #defines to more closely reflect Intel docs, which don't refer
> to the ICH IDE stuff as PIIX4s. Let me know if I should drop that bit.
> 
> Anyway, I've added a little more - some of the ICH3 IDs, and a few user messages.

Would it be possible to produce two patches, the first adding new ids,
and the second doing the rename you want?

The first can be applied quickly, the second is cleanup and might be
delayed a bit before going in, if we indeed do want to do the renames.

	Jeff



