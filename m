Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSGILAC>; Tue, 9 Jul 2002 07:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSGILAB>; Tue, 9 Jul 2002 07:00:01 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:56679 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S313563AbSGILAB>; Tue, 9 Jul 2002 07:00:01 -0400
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 9 Jul 2002 13:01:11 +0200
MIME-Version: 1.0
Subject: Removing CAP_SYS_RAWIO
Message-ID: <3D2ADE97.3211.9586B6@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello! Has anyone experience with removing CAP_SYS_RAWIO capability 
in the recent 2.4 kernels? I searched around to look for real life 
examples, but the only definitive answer seems to be that X breaks. 
>From my head, other candidates to breaking are things like hwclock 
and setserial, maybe i am wrong? 



Thanks,
Pedro
