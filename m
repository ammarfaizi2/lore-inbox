Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317306AbSHGKr0>; Wed, 7 Aug 2002 06:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317327AbSHGKr0>; Wed, 7 Aug 2002 06:47:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40150 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317306AbSHGKrZ>;
	Wed, 7 Aug 2002 06:47:25 -0400
Date: Wed, 07 Aug 2002 03:38:20 -0700 (PDT)
Message-Id: <20020807.033820.126760020.davem@redhat.com>
To: kwijibo@zianet.com
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: Tigon3 and jumbo frames
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D5045C1.6050302@zianet.com>
References: <3D5045C1.6050302@zianet.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kwijibo@zianet.com
   Date: Tue, 06 Aug 2002 15:55:13 -0600

   Does the new version of the tigon 3 (tg3) drivers support jumbo
   frames?

It works, use a direct connection between two tg3 cards if you
don't believe us :-)

