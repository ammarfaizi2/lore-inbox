Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310523AbSCEHsL>; Tue, 5 Mar 2002 02:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310526AbSCEHsB>; Tue, 5 Mar 2002 02:48:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36285 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310523AbSCEHr5> convert rfc822-to-8bit;
	Tue, 5 Mar 2002 02:47:57 -0500
Date: Mon, 04 Mar 2002 23:45:48 -0800 (PST)
Message-Id: <20020304.234548.39156672.davem@redhat.com>
To: linux-kernel@vger.kernel.org, tlan@stud.ntnu.no
Cc: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA-0.94] Fifth test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020304172617.B1648@stud.ntnu.no>
In-Reply-To: <20020304164453.A27587@stud.ntnu.no>
	<3C83993A.94FE655E@mandrakesoft.com>
	<20020304172617.B1648@stud.ntnu.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Langås <tlan@stud.ntnu.no>
   Date: Mon, 4 Mar 2002 17:26:17 +0100

   However, there seems to be a problem with the bw_tcp-tool, cause it just
   hangs, trying to strace it won't gimme me much usefull info about why it
   hangs either. (it worked like a charm with 1500 MTUs).
   
Expect a 0.95 release later tonight, which should fix this.
