Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266040AbRHAJKA>; Wed, 1 Aug 2001 05:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266150AbRHAJJu>; Wed, 1 Aug 2001 05:09:50 -0400
Received: from [213.96.224.204] ([213.96.224.204]:19719 "HELO manty.net")
	by vger.kernel.org with SMTP id <S266040AbRHAJJo>;
	Wed, 1 Aug 2001 05:09:44 -0400
Date: Wed, 1 Aug 2001 11:09:48 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Cc: bao.ha@srs.gov, aris@conectiva.com.br, dupuis@lei.ucl.ac.be
Subject: Problems trying to use a Intel EtherExpress Pro/10
Message-ID: <20010801110948.A762@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a couple of Intel NICs based on chip FA82595TX, the NIC model is
650092, wich is not listed on Intel's site. Anyway, it is recogniced on both
2.2.19 and 2.4.7 as an Intel EtherExpress Pro/10 ISA, I can ifconfig it and
everything, but when I try to use it, I get either no packets sent, none
received, or packets sent but also a lot of errors and carrier, anyway, I
never get to receive a packet.

I have tried both cards on different IO ports, different irqs and different
machines, I have disconected the flash as I have read on the code that this
could cause problems, but nothing helps.

Anybody has any idea of how to solve this?

Thanks in advance!

Regards...
-- 
Manty/BestiaTester -> http://manty.net
