Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290707AbSBMEZD>; Tue, 12 Feb 2002 23:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291346AbSBMEYx>; Tue, 12 Feb 2002 23:24:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41353 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290707AbSBMEYo>;
	Tue, 12 Feb 2002 23:24:44 -0500
Date: Tue, 12 Feb 2002 20:22:33 -0800 (PST)
Message-Id: <20020212.202233.102575669.davem@redhat.com>
To: ac9410@bellsouth.net
Cc: alan@clueserver.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 sound module problem
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C69E2C7.3E749061@bellsouth.net>
In-Reply-To: <3C69E2C7.3E749061@bellsouth.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Albert Cranford <ac9410@bellsouth.net>
   Date: Tue, 12 Feb 2002 22:51:35 -0500

   Not sure if this was the same message I received. but here
   is the patch I used to get around my sound problem in
   2.5.4.
   Linus, please apply to 2.5.5 pre1

Umm, I don't it is safe to assume that only ISA sound drivers end up
making use of this code.  I would like you to prove that before
submitting this change.
