Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313971AbSDQAD7>; Tue, 16 Apr 2002 20:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313974AbSDQAD6>; Tue, 16 Apr 2002 20:03:58 -0400
Received: from jalon.able.es ([212.97.163.2]:21466 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S313971AbSDQAD5>;
	Tue, 16 Apr 2002 20:03:57 -0400
Date: Wed, 17 Apr 2002 02:03:51 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.19-pre7-jam1
Message-ID: <20020417000351.GC1800@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

New version, just collected latest important bugfixes:

- Serial port number assign (05-serial.gz)
- pagemap.h include for fs/ (04-fs-pagemap.gz)
- unlocking order in buffer.c::end_buffer_io_kiobuf (03-unlock-bh-before.gz)

And a couple new additions:

- ide update -3a (very shrinked wrt original, the big ppc part has gone
  in mainline)
- netconsole-C2-2 (for my beowulf...)

Rest as usual, O1-sched-k3 (is any backport of the updates planned ??)
mini-low-lat, splitted-vm-33, bproc-3.1.9.

Enjoy !!

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam1 #1 SMP Wed Apr 17 00:42:27 CEST 2002 i686
