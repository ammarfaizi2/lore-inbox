Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266303AbRGJNv7>; Tue, 10 Jul 2001 09:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266181AbRGJNvt>; Tue, 10 Jul 2001 09:51:49 -0400
Received: from weta.f00f.org ([203.167.249.89]:39042 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266303AbRGJNve>;
	Tue, 10 Jul 2001 09:51:34 -0400
Date: Wed, 11 Jul 2001 01:51:28 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How many pentium-3 processors does SMP support?
Message-ID: <20010711015128.E31799@weta.f00f.org>
In-Reply-To: <Pine.GSO.4.21.0107092315140.493-100000@faith.cs.utah.edu> <9ie450$d1p$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ie450$d1p$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 10:34:24PM -0700, H. Peter Anvin wrote:

    It supports up to 32, if you can find a machine that has that
    many.

I think 8-way is about as high as anything common goes to, maybe
16. The cpu array is declared 32 long, maybe this should be changed to
8 by default?



  --cw
