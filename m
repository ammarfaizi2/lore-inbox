Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbTA2POg>; Wed, 29 Jan 2003 10:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTA2POg>; Wed, 29 Jan 2003 10:14:36 -0500
Received: from mail.ithnet.com ([217.64.64.8]:33040 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S266116AbTA2POf>;
	Wed, 29 Jan 2003 10:14:35 -0500
Date: Wed, 29 Jan 2003 16:23:54 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: no more MTRRs available ?
Message-Id: <20030129162354.55f2ace4.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

what exactly does

	mtrr: no more MTRRs available
	mtrr: no more MTRRs available

during boot mean? What can I do against this? This comes up while booting a
system with 6GB and P-III 1.4 GHz (Serverworks chipset). Kernel is 2.4.20.

Thanks for any hints.

-- 
Regards,
Stephan

