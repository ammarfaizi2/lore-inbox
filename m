Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbREPI50>; Wed, 16 May 2001 04:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261843AbREPI5P>; Wed, 16 May 2001 04:57:15 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:62472 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S261839AbREPI5F>;
	Wed, 16 May 2001 04:57:05 -0400
Date: Wed, 16 May 2001 10:57:02 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: ATA overlap/queuing support ?
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B0240DE.24121B51@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there support in linux for ATA overlap/queuing ?

It should ( among other things ) improve concurent performance
of two devices on the same channel.

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
