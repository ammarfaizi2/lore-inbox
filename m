Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292922AbSB0VfH>; Wed, 27 Feb 2002 16:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292978AbSB0Veq>; Wed, 27 Feb 2002 16:34:46 -0500
Received: from tapu.f00f.org ([66.60.186.129]:46978 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S292975AbSB0VeG>;
	Wed, 27 Feb 2002 16:34:06 -0500
Date: Wed, 27 Feb 2002 13:33:44 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Barubary <barubary@cox.net>, linux-kernel@vger.kernel.org,
        Rick Stevens <rstevens@vitalstream.com>
Subject: Re: Big file support\
Message-ID: <20020227213344.GA23938@tapu.f00f.org>
In-Reply-To: <3C7D3587.8080609@vitalstream.com> <006301c1bfc9$a5c6de90$a7eb0544@CX535256D> <20020227223426.N23151@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020227223426.N23151@mea-ext.zmailer.org>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 10:34:26PM +0200, Matti Aarnio wrote:

    It looks like the LOOP driver lands in between -- it should be LFS
    capable, but it isn't.

Really?

I used to use loop with large lop files all the time, I had to fix the
utils that mounted/attached the loop device though, as they would fail
without proper LFS build smarts.


   --cw
