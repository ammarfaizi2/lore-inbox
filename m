Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSHBB7B>; Thu, 1 Aug 2002 21:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSHBB7B>; Thu, 1 Aug 2002 21:59:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40095 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317611AbSHBB7B>;
	Thu, 1 Aug 2002 21:59:01 -0400
Date: Thu, 01 Aug 2002 18:50:29 -0700 (PDT)
Message-Id: <20020801.185029.79271639.davem@redhat.com>
To: riel@conectiva.com.br
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       rohit.seth@intel.com, sunil.saxena@intel.com, asit.k.mallick@intel.com,
       gh@us.ibm.com
Subject: Re: large page patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44L.0208012246390.23404-100000@imladris.surriel.com>
References: <20020801.174301.123634127.davem@redhat.com>
	<Pine.LNX.4.44L.0208012246390.23404-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Thu, 1 Aug 2002 22:55:05 -0300 (BRT)
   
   IMHO we shouldn't blindly decide for (or against!) this patch
   but also carefully look at the large page patch from RHAS (which
   got added to -aa recently) and the large page patch which IBM
   is working on.

And the one from Naohiko Shimizu which is my personal favorite
because sparc64 support is there :)

http://shimizu-lab.dt.u-tokai.ac.jp/lsp.html
