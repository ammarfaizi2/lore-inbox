Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSIDXVD>; Wed, 4 Sep 2002 19:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSIDXVD>; Wed, 4 Sep 2002 19:21:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17890 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316235AbSIDXVB>;
	Wed, 4 Sep 2002 19:21:01 -0400
Date: Wed, 04 Sep 2002 16:18:32 -0700 (PDT)
Message-Id: <20020904.161832.66541667.davem@redhat.com>
To: thunder@lightweight.ods.org
Cc: rusty@rustcorp.com.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209040943260.3373-100000@hawkeye.luckynet.adm>
References: <20020903.220514.21399526.davem@redhat.com>
	<Pine.LNX.4.44.0209040943260.3373-100000@hawkeye.luckynet.adm>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thunder from the hill <thunder@lightweight.ods.org>
   Date: Wed, 4 Sep 2002 09:44:51 -0600 (MDT)
   
   I couldn't use gcc 3.* on sparc64 for some weird reason

3.0 should be broken yes, but 3.1 definitely works as I use
it here for occaisionaly test builds all the time.
