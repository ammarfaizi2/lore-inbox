Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271779AbRH2BWC>; Tue, 28 Aug 2001 21:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271788AbRH2BVv>; Tue, 28 Aug 2001 21:21:51 -0400
Received: from [194.46.8.33] ([194.46.8.33]:38663 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S271779AbRH2BVl>;
	Tue, 28 Aug 2001 21:21:41 -0400
Date: Wed, 29 Aug 2001 01:50:50 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: Vger triggering alerts
Message-ID: <20010829015050.F27869@vnl.com>
In-Reply-To: <OF24A34168.0F477E02-ON85256B29.0052E00A@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF24A34168.0F477E02-ON85256B29.0052E00A@raleigh.ibm.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any one have an idea why I'd be getting these snort alerts
from vger mail transactions?

[**] [111:4:1] spp_stream4: WINDOW VIOLATION detection [**]
08/27-01:01:27.806453 199.183.24.194:45473 -> 194.46.0.61:25
TCP TTL:49 TOS:0x0 ID:25963 IpLen:20 DgmLen:74 DF
***AP*** Seq: 0x3DFC914F  Ack: 0xC8CF2D66  Win: 0x16D0  TcpLen: 32
TCP Options (3) => NOP NOP TS: 137819194 96190743 

-- 
------------------------------------------------------
Use Linux: A computer        Dale Amon, CEO/MD
is a terrible thing          Village Networking Ltd
to waste.                    Belfast, Northern Ireland
------------------------------------------------------
