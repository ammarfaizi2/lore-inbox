Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSJRGPX>; Fri, 18 Oct 2002 02:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbSJRGPW>; Fri, 18 Oct 2002 02:15:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32707 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264844AbSJRGO3>;
	Fri, 18 Oct 2002 02:14:29 -0400
Date: Thu, 17 Oct 2002 23:12:49 -0700 (PDT)
Message-Id: <20021017.231249.14334285.davem@redhat.com>
To: atai@atai.org, lichengtai@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tigon3 driver problem with raw socket on 2.4.20-pre10-ac2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021018044402.42069.qmail@web10508.mail.yahoo.com>
References: <20021018044402.42069.qmail@web10508.mail.yahoo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andy Tai <lichengtai@yahoo.com>
   Date: Thu, 17 Oct 2002 21:44:02 -0700 (PDT)

   Thus this indicates the problem is in the Tigon3 driver.

Please retest with 2.4.19.

There have actually been a lot of Athlon based problem reports in the
2.4.20 series.  And to be honest, tigon3 hardware is buggy in spots.
You could also download and try Broadcom's driver with your card in
2.4.20-pre10-ac2 if you'd like to rule out tg3.c specifically.

