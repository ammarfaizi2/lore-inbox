Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292842AbSCJSIG>; Sun, 10 Mar 2002 13:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292846AbSCJSH4>; Sun, 10 Mar 2002 13:07:56 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:43146 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S292842AbSCJSHk>; Sun, 10 Mar 2002 13:07:40 -0500
Date: Sun, 10 Mar 2002 19:06:58 +0100
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: bzdisk boot failure
Message-ID: <20020310190658.A436@df1tlpc.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made a bootfloppy with kernel 2.4.19-pre2 with make bzdisk.

When booting from that floppy I get ..

1000
AX:0212
BX:6000
CX:0101
DX:0100
Uncompressing Linux ..
ran out of input data
-- System halted

Is this a bug or have I missed something?

-- 
Klaus
