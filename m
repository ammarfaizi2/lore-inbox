Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313174AbSDKIUf>; Thu, 11 Apr 2002 04:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSDKIUe>; Thu, 11 Apr 2002 04:20:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25354 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313174AbSDKIUe>;
	Thu, 11 Apr 2002 04:20:34 -0400
Date: Thu, 11 Apr 2002 10:20:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: profile=x broken in 2.5?
Message-ID: <20020411082035.GG13856@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just noticed that readprofile doesn't work as well as it used too in
2.5.8-pre3 at least (-pre2 too, dunno how far back this goes...). I get
very few accounted symbols as compared to 2.4, and lots seem to be
missing (block stuff, ide stuff, etc).

I'll investigate this further, but maybe this problem is already known.

-- 
Jens Axboe

