Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbRBTSQZ>; Tue, 20 Feb 2001 13:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbRBTSQP>; Tue, 20 Feb 2001 13:16:15 -0500
Received: from ptolemy.arc.nasa.gov ([128.102.112.134]:46316 "EHLO
	ptolemy.arc.nasa.gov") by vger.kernel.org with ESMTP
	id <S130088AbRBTSQN>; Tue, 20 Feb 2001 13:16:13 -0500
Date: Tue, 20 Feb 2001 10:16:22 -0800
From: Dan Christian <dac@ptolemy.arc.nasa.gov>
To: linux-kernel@vger.kernel.org
Subject: hang on mount, 2.4.2-pre4, VIA
Message-ID: <20010220101622.A18117@ptolemy.arc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I just tried upgrading to 2.4.2-pre4 from 2.4.1 and get a hang when
mounting the file systems.  I have the same problem with 2.4.1-ac18.

The system is a single processor P3 and uses a VIA chipset (Tyan
something-or-other).  DMA, multi-sector IO, and 32bit sync are enabled
using hdparm (just before the hang).  There are two Ultra-66 drives
attached to one IDE channel and a CD-RW on a second IDE channel.

The distribution is RH7 with recent security patches and modutils
2.4.2.  The kernel was built with kgcc.

Has anybody else seen this?

I'm not on the list.  Please CC me on any replies.

-Dan

-- 
Dan Christian		(650) 604-4507		FAX 604-4036
NASA Ames Research Center, Mail Stop 269-3, Moffett Field, CA 94035
