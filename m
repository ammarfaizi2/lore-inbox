Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311285AbSCQENE>; Sat, 16 Mar 2002 23:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311287AbSCQEMo>; Sat, 16 Mar 2002 23:12:44 -0500
Received: from tapu.f00f.org ([66.60.186.129]:11942 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S311285AbSCQEMe>;
	Sat, 16 Mar 2002 23:12:34 -0500
Date: Sat, 16 Mar 2002 20:12:19 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, yodaiken@fsmlabs.com,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020317041219.GB14116@tapu.f00f.org>
In-Reply-To: <20020317025004.GA13644@tapu.f00f.org> <E16mRZx-00085G-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16mRZx-00085G-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 03:43:29AM +0000, Alan Cox wrote:

    You are labouring under the belief that processors touch the frame
    buffer nowdays. For a current accelerated frame buffer that isnt
    very true.

/s/frame-buffer/hunk-of-memory/

Either way, we have tens of MB of ram where we either put textures,
options or whatever --- the CPU has to meddle with it one way or
another.



  --cw
