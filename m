Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319071AbSIDGIV>; Wed, 4 Sep 2002 02:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319076AbSIDGIV>; Wed, 4 Sep 2002 02:08:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14043 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319071AbSIDGIV>;
	Wed, 4 Sep 2002 02:08:21 -0400
Date: Tue, 03 Sep 2002 23:06:07 -0700 (PDT)
Message-Id: <20020903.230607.24231380.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020904060105.C263E2C1B6@lists.samba.org>
References: <20020903.220514.21399526.davem@redhat.com>
	<20020904060105.C263E2C1B6@lists.samba.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Wed, 04 Sep 2002 16:00:35 +1000
   
   I was actually proposing to provide a patch to an egcs version of your
   choice which you could provide as kgcc to your users.  But RH seem to
   have taken down the SRPM for 2.92.11 (egcs64-19980921-4.src.rpm).

The last sparc64 Red Hat distribution was 6.2  And it still works
unchanged with current kernels. :-)
