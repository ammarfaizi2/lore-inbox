Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319211AbSH2OQW>; Thu, 29 Aug 2002 10:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319212AbSH2OQW>; Thu, 29 Aug 2002 10:16:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33444 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319211AbSH2OQV>;
	Thu, 29 Aug 2002 10:16:21 -0400
Date: Thu, 29 Aug 2002 07:14:52 -0700 (PDT)
Message-Id: <20020829.071452.16869863.davem@redhat.com>
To: plars@austin.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: LTP Nightly BK Test Failure - ip_nat_helper
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1030629915.5187.13.camel@plars.austin.ibm.com>
References: <1030629915.5187.13.camel@plars.austin.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Larson <plars@austin.ibm.com>
   Date: 29 Aug 2002 09:05:14 -0500

   The nightly bk testing last night found a new build error last night
   with ip_nat_helper

Just some __FUNCTION__ string pasting that newer GCC doesn't like.
Feel free to submit a patch.
   
Franks a lot,
David S. Miller
davem@redhat.com
