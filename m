Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbTBCWRR>; Mon, 3 Feb 2003 17:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbTBCWRQ>; Mon, 3 Feb 2003 17:17:16 -0500
Received: from user-24-214-38-190.knology.net ([24.214.38.190]:32520 "EHLO
	email") by vger.kernel.org with ESMTP id <S266917AbTBCWRP> convert rfc822-to-8bit;
	Mon, 3 Feb 2003 17:17:15 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ro0tSiEgE <lkml@ro0tsiege.org>
To: linux-kernel@vger.kernel.org
Subject: BTTV Compile Problem
Date: Mon, 3 Feb 2003 16:26:43 -0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302031626.43618.lkml@ro0tsiege.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What would be the cause of me having to insert 
#include "../../sound/sound_firmware.c" into drivers/media/video/bttv-cards.c
for bttv to compile into the kernel?

TIA


