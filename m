Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313505AbSFELsA>; Wed, 5 Jun 2002 07:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSFELr7>; Wed, 5 Jun 2002 07:47:59 -0400
Received: from kim.it.uu.se ([130.238.12.178]:50058 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S313505AbSFELr7>;
	Wed, 5 Jun 2002 07:47:59 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15613.64110.996891.14945@kim.it.uu.se>
Date: Wed, 5 Jun 2002 13:47:58 +0200
To: linux-kernel@vger.kernel.org
Subject: ide-tape problem in 2.4.19-pre9?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Seagate ATAPI tape drive used to work great under 2.4.*,
but earlier this week I found that doing a backup under 2.4.19-pre9
caused the machine to lock up _hard_ after a while. This happened
twice in a row. Rebooting into 2.2.21 and it worked reliably again.

This is with ide-tape, not st + ide-scsi.

I'll try to investigate this further later when I have time.

/Mikael
