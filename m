Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276204AbRJCNNS>; Wed, 3 Oct 2001 09:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276203AbRJCNNI>; Wed, 3 Oct 2001 09:13:08 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:41099 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S276201AbRJCNND>; Wed, 3 Oct 2001 09:13:03 -0400
Date: Wed, 3 Oct 2001 15:12:48 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re:2.4.10 doesn't boot
Message-ID: <20011003151248.A614@df1tlpc.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The default type of the processor has changed from P-II to P-III.

If you have P-II and not changed the default the system will not boot.

Check your linux/.config file (e.g. make xconfig)

-- 
Best regards
Klaus Dittrich

e-mail: kladit@t-online.de
