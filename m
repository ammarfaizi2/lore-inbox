Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312279AbSERK0f>; Sat, 18 May 2002 06:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312296AbSERK0e>; Sat, 18 May 2002 06:26:34 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:58512 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S312279AbSERK0e> convert rfc822-to-8bit; Sat, 18 May 2002 06:26:34 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixing supermount for > 2.4.19pre4
Date: Sat, 18 May 2002 12:26:03 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
Cc: =?iso-8859-1?q?J=F6rg=20Prante?= <joergprante@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205181226.03997.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

your patch for supermount does not work. Now it's even not possible to list 
the content via ls -lsa /mnt ... Mount hangs, no access is made, nothing.

Tested with your jp12 patchset and with my patchset wolk.

-- 
Kind regards
        Marc-Christian Petersen

