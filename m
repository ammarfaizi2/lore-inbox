Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315380AbSEBT1U>; Thu, 2 May 2002 15:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSEBT1S>; Thu, 2 May 2002 15:27:18 -0400
Received: from zeus.kernel.org ([204.152.189.113]:39412 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S315380AbSEBT1C>;
	Thu, 2 May 2002 15:27:02 -0400
Date: Thu, 2 May 2002 08:40:46 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stephen Samuel <samuel@bcgreen.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Andre Hedrick <andre@linux-ide.org>,
        linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Message-ID: <20020502154046.GU574@matchmail.com>
Mail-Followup-To: Stephen Samuel <samuel@bcgreen.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10204260028140.10216-100000@master.linux-ide.org> <Pine.LNX.3.96.1020429173812.26335B-100000@gatekeeper.tmr.com> <20020502034530.GT574@matchmail.com> <3CD0F846.3070605@bcgreen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 01:26:46AM -0700, Stephen Samuel wrote:
> I ran a similar type of test on a 2.4.9.31 (redhat 7.1 ) kernel.
> With the CD on HDD, I could read off of HDA just peachy while
> the system was choking on a scratched (aol) cd.
> 
> I did a WC of a 300MB file (only 256MB of ram on the system,
> so that's guaranteed to not fit in any cache).
> 
> Times to read the file were statistically equivalent whether
> the system was choking on the CD or not.

Great, can you post the lspci output for your IDE chipset(s)?
