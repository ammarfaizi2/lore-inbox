Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319059AbSIDFOy>; Wed, 4 Sep 2002 01:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319060AbSIDFOx>; Wed, 4 Sep 2002 01:14:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56026 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319059AbSIDFOu>;
	Wed, 4 Sep 2002 01:14:50 -0400
Date: Tue, 03 Sep 2002 22:12:35 -0700 (PDT)
Message-Id: <20020903.221235.46318097.davem@redhat.com>
To: torvalds@transmeta.com
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209032216570.1439-100000@home.transmeta.com>
References: <20020903.220514.21399526.davem@redhat.com>
	<Pine.LNX.4.44.0209032216570.1439-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Tue, 3 Sep 2002 22:17:39 -0700 (PDT)
   
   Well, I don't think you have to go to 3.1.x.
   
Yes I do, anything after our standard sparc64 (ie. egcs-2.92.11)
compiler up until 3.1.x is seriously unusable for kernel builds.
