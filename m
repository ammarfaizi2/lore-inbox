Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSFASrV>; Sat, 1 Jun 2002 14:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313767AbSFASrU>; Sat, 1 Jun 2002 14:47:20 -0400
Received: from smtp.comcast.net ([24.153.64.2]:45409 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S313421AbSFASrU>;
	Sat, 1 Jun 2002 14:47:20 -0400
Date: Sat, 01 Jun 2002 14:47:37 -0400
From: Tom Vier <tmv@comcast.net>
Subject: /proc/slab garbage
In-Reply-To: <Pine.LNX.4.21.0205281905260.7798-100000@freak.distro.conectiva>
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20020601184737.GA618@zero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when i cat /proc/slabinfo, after the normal info, it's spits out garbage;
seemingly random memory contents. it's printing past the end of the buffer.
i can email an example upon request.

Linux zero 2.4.19-pre9 #1 Tue May 28 20:54:41 EDT 2002 alpha unknown

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
