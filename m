Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271989AbRH2Ozn>; Wed, 29 Aug 2001 10:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271988AbRH2Ozd>; Wed, 29 Aug 2001 10:55:33 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:8423 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S271986AbRH2OzX>;
	Wed, 29 Aug 2001 10:55:23 -0400
Message-ID: <3B8D0267.83C11572@candelatech.com>
Date: Wed, 29 Aug 2001 07:55:35 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: min/max status?
In-Reply-To: <200108290911.f7T9Btb06402@wildsau.idv-edu.uni-linz.ac.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Rosmanith wrote:
> 
> hi,
> 
> I'd like to know of min/max will stay in kernel.h in their current (and
> fucking ugly, IMO) form or if they eventually will be moved to something
> like type_min() type_max().
> 
> I've read a lot of emails contra the 3-parm. min/max macros. Does our
> supreme deity listen to HIS followers or is this more like a
> "le etat est moi" --- "der kernel bin ich" question?

If you are so blindly opposed to the min/max thing, just use
if (x > z) {
	go do thing
}
else {
	go do other thing
}

Otherwise, get over it and lets move on.

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
