Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261929AbRESSB5>; Sat, 19 May 2001 14:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261932AbRESSBr>; Sat, 19 May 2001 14:01:47 -0400
Received: from hera.cwi.nl ([192.16.191.8]:2540 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261929AbRESSBh>;
	Sat, 19 May 2001 14:01:37 -0400
Date: Sat, 19 May 2001 20:01:35 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105191801.UAA53017.aeb@vlet.cwi.nl>
To: aia21@cam.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: Q: ioctl BLKGETSIZE return value units?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What are the units of the return value of the BLKGETSIZE ioctl on Linux?

Sectors of size 512.

> or is it in units of sector size bytes as returned by BLKSSZGET

No.

Andries
