Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSJNNmv>; Mon, 14 Oct 2002 09:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSJNNmv>; Mon, 14 Oct 2002 09:42:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43673 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261640AbSJNNmu>;
	Mon, 14 Oct 2002 09:42:50 -0400
Date: Mon, 14 Oct 2002 06:41:42 -0700 (PDT)
Message-Id: <20021014.064142.94841093.davem@redhat.com>
To: woockie@expressz.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42-ac1 serial compile error on sparc
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.96.1021014152950.28326A-100000@ligur.expressz.com>
References: <Pine.LNX.3.96.1021014152950.28326A-100000@ligur.expressz.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "BODA Karoly jr." <woockie@expressz.com>
   Date: Mon, 14 Oct 2002 15:32:53 +0200 (CEST)

   	The serial.h is missing for the sparc architecture:

The 8250 driver is not supported on Sparc, please do
not enable it.
