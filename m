Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130741AbRBPTBi>; Fri, 16 Feb 2001 14:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130821AbRBPTB1>; Fri, 16 Feb 2001 14:01:27 -0500
Received: from mail.valinux.com ([198.186.202.175]:2820 "EHLO mail.valinux.com")
	by vger.kernel.org with ESMTP id <S130741AbRBPTBR>;
	Fri, 16 Feb 2001 14:01:17 -0500
Message-ID: <3A8D78ED.B7D06362@valinux.com>
Date: Fri, 16 Feb 2001 11:01:01 -0800
From: Samuel Flory <sflory@valinux.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre11-va1.7smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, "tytso@valinux.com" <tytso@valinux.com>,
        Chip Salzenberg <chip@valinux.com>
Subject: Re: mke2fs and kernel VM issues
In-Reply-To: <E14ThUy-0002ed-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > heavily modifed VA kernel based on 2.2.18.  Is there a kernel which is
> > believed to be a known good kernel?  (both 2.2.x and 2.4.x)
> 
> I've not seen the problem on unmodified 2.2.18. The 2.2.17/18 VM does have
> its problems but not these. 2.2.19pre3 and higher have the Andrea VM fixes which
> have worked wonders for everyone so far.


  Hmm I believe Chip got his VM patches from Andrea.  So the behavior
may be more 2.2.19pre3ish than 2.2.18ish.

-- 
Solving people's computer problems always
requires more hardware be given to you.
(The Second Rule of Hardware Acquisition)
Samuel J. Flory  <sam@valinux.com>
