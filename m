Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272507AbRH3Vur>; Thu, 30 Aug 2001 17:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272510AbRH3Vub>; Thu, 30 Aug 2001 17:50:31 -0400
Received: from mx1.port.ru ([194.67.57.11]:64012 "EHLO smtp1.port.ru")
	by vger.kernel.org with ESMTP id <S272507AbRH3Vtq>;
	Thu, 30 Aug 2001 17:49:46 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200108310212.f7V2Cbg01948@vegae.deep.net>
Subject: 2.4.9-ac1 RAID-5 resync causes PPP connection to be unusable
To: linux-kernel@vger.kernel.org
Date: Fri, 31 Aug 2001 02:12:36 +0000 (UTC)
Cc: kevin@labsysgrp.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can probably reproduce this pretty easily, if anyone is interested and can
> give me some idea where to look for the cause...
      So did "hdparm -u1 /dev/yourdrive(s)" fixed the problem?
   i have seen something quite like that, though that was an Am5x86 with
   IBM Deskstar 75GXP...
      In my case unmaskirq didn`t helped.
   And ppp interface errcount surely was being increased,,

cheers,
 Sam
