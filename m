Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293242AbSDCUmK>; Wed, 3 Apr 2002 15:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291401AbSDCUmB>; Wed, 3 Apr 2002 15:42:01 -0500
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:8076 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id <S312393AbSDCUlt>; Wed, 3 Apr 2002 15:41:49 -0500
Mime-Version: 1.0
Message-Id: <a0510030bb8d1193e3a25@[129.98.91.150]>
In-Reply-To: <3CAB551E.95990FBB@zip.com.au>
Date: Wed, 3 Apr 2002 15:41:49 -0500
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: Mount corrupts an ext2 filesystem on a RAM disk
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.

>It works for me.

You left out a *crucial* step. "cd" into the mounted ramdisk 
directory. This step is what does the damage.

I have sent the files directly to Andrew.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
