Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSLUVjH>; Sat, 21 Dec 2002 16:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbSLUVjH>; Sat, 21 Dec 2002 16:39:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60386 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264986AbSLUVjG>;
	Sat, 21 Dec 2002 16:39:06 -0500
Date: Sat, 21 Dec 2002 13:41:33 -0800 (PST)
Message-Id: <20021221.134133.123990503.davem@redhat.com>
To: gibbs@scsiguy.com
Cc: wli@holomorphy.com, janetmor@us.ibm.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <4085892704.1040483953@aslan.scsiguy.com>
References: <223910000.1040435985@aslan.btc.adaptec.com>
	<1040443851.1441.0.camel@rth.ninka.net>
	<4085892704.1040483953@aslan.scsiguy.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
   Date: Sat, 21 Dec 2002 08:19:13 -0700
   
   I think that if you look here, I put more information
   into BK than most people.

When I read you say that you split the changesets into individual
precise changes in perforce, and you're not willing to translate
that into individual BK changesets, that is what makes me say
that you aren't using the tool properly.

Have a look at my changesets sometime, Justin.  Just adding a missing
include, that's a changeset.  That's the kind of thing I look for, and
when I get more changes than that in a patch I have to integrate, I
tend to cringe.

