Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132373AbRDNOnO>; Sat, 14 Apr 2001 10:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132387AbRDNOnE>; Sat, 14 Apr 2001 10:43:04 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:25350 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S132373AbRDNOm6>; Sat, 14 Apr 2001 10:42:58 -0400
Date: Sat, 14 Apr 2001 16:42:54 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: KERNEL: assertion (tp->lost_out == 0) failed at tcp_input.c(1202):tcp_remove_reno_sacks
Message-ID: <20010414164254.A13247@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running 2.4.3, I saw the following message a few times:

KERNEL: assertion (tp->lost_out == 0) failed at
tcp_input.c(1202):tcp_remove_reno_sacks

Is that bad, or should I just ignore it?


Kurt

