Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbRHFNLH>; Mon, 6 Aug 2001 09:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268429AbRHFNK5>; Mon, 6 Aug 2001 09:10:57 -0400
Received: from weta.f00f.org ([203.167.249.89]:61072 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S268428AbRHFNKw>;
	Mon, 6 Aug 2001 09:10:52 -0400
Date: Tue, 7 Aug 2001 01:11:47 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org
Subject: Re: [LONGish] Brief analysis of VMAs (was: /proc/<n>/maps getting
Message-ID: <20010807011147.A24044@weta.f00f.org>
In-Reply-To: <997093086.7179.21.camel@typhaon> <E15Tk4u-0000wy-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15Tk4u-0000wy-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 02:05:52PM +0100, Alan Cox wrote:

    Are you sure thats not evolution being built with a debugging malloc of
    some kind ?

The syscall patterns _look_ like those of glibc on my system...



  --cw
