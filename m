Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267683AbTAMJaH>; Mon, 13 Jan 2003 04:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267721AbTAMJaH>; Mon, 13 Jan 2003 04:30:07 -0500
Received: from denise.shiny.it ([194.20.232.1]:12223 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S267683AbTAMJaG>;
	Mon, 13 Jan 2003 04:30:06 -0500
Message-ID: <XFMail.20030113103851.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20030112075844.GA16050@mark.mielke.cc>
Date: Mon, 13 Jan 2003 10:38:51 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: RE: inefficient RT vs efficient non-RT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Think about it logically -- if I can process 5X as much data as you can on
> the same hardware, but I can't guarantee that *at* 5X no data will be lost,
> but then, I only run at 1X (the same speed as you), how many packets have
> a chance of being lost?

Real time systems are not supposed to be faster than non-RT ones. They
just provide a reliable response time.


Bye.

