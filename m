Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271365AbRIAUmj>; Sat, 1 Sep 2001 16:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271349AbRIAUma>; Sat, 1 Sep 2001 16:42:30 -0400
Received: from buzz.sonic.net ([208.201.224.78]:15921 "EHLO buzz.sonic.net")
	by vger.kernel.org with ESMTP id <S271348AbRIAUmL>;
	Sat, 1 Sep 2001 16:42:11 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sat, 1 Sep 2001 13:42:29 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: is bzImage container large enough?
Message-ID: <20010901134229.A16630@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22500.999376181@ocs3.ocs-net>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2001 at 06:29:41AM +1000, Keith Owens wrote:
> allmod and make randconfig.  Included in separate mail.

randconfig?

This scares me.   :->

Btw, are such things independent of CML being used?  Was wondering if a
"randconfig" might use CML2 to validate the configuration (as far as CML2
knows about it).  _Might_ be useful to enhance CML2 to track down
incompatible configurations.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
