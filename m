Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129612AbRBOSXL>; Thu, 15 Feb 2001 13:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRBOSXB>; Thu, 15 Feb 2001 13:23:01 -0500
Received: from oberon.gaumina.lt ([193.219.244.227]:20236 "HELO
	oberon.gaumina.lt") by vger.kernel.org with SMTP id <S129612AbRBOSWp> convert rfc822-to-8bit;
	Thu, 15 Feb 2001 13:22:45 -0500
From: Andrius Adomaitis <charta@gaumina.lt>
To: linux-kernel@vger.kernel.org
Subject: strange tcp errors
Date: Thu, 15 Feb 2001 20:21:37 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0102152021370F.00312@castle.gaumina.lt>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Messages in my kernel log:

node1 kernel: sending pkt_too_big to self
node1 kernel: KERNEL: assertion (tp->lost_out == 0) failed at 
tcp_input.c(1202):tcp_remove_reno_sacks

Kernel 2.4.1-ac13.

Maybe someone want to say me what does it mean and how serious it is?
Any fixes?

Thanks.
--
Andrius
charta@gaumina.lt
