Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276703AbRJGWXm>; Sun, 7 Oct 2001 18:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276704AbRJGWXd>; Sun, 7 Oct 2001 18:23:33 -0400
Received: from mailb.telia.com ([194.22.194.6]:5647 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S276703AbRJGWX0>;
	Sun, 7 Oct 2001 18:23:26 -0400
Message-ID: <3BC0D5F9.3C6DCF93@canit.se>
Date: Mon, 08 Oct 2001 00:23:53 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG] emu10k1 and SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with my sblive card with some program when I compile
2.4.10 and -ac8 for SMP.

This happens with programs from loki and the machine stops or power down
(yes an actuall power down). I'am sure this is sound related as stuff
works if I don't load the emu10k1 driver and it only happens with SMP.


