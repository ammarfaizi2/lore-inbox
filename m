Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271106AbRHYHAD>; Sat, 25 Aug 2001 03:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272393AbRHYG7x>; Sat, 25 Aug 2001 02:59:53 -0400
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:61922 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S271106AbRHYG7e>; Sat, 25 Aug 2001 02:59:34 -0400
Message-ID: <3B874CE5.DF94D417@bigfoot.com>
Date: Fri, 24 Aug 2001 23:59:49 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p9ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: mount failure, SCSI emulation, 2.2.20pre9
In-Reply-To: <3B85B1E8.99D125C1@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot kernel errors for mount failure

Aug 24 23:22:11 abit kernel: attempt to access beyond end of device 
Aug 24 23:22:11 abit kernel: 0b:00: rw=0, want=33, limit=0 
Aug 24 23:22:11 abit kernel: dev 0b:00 blksize=1024 blocknr=32 sector=64 size=1024 count=1 
Aug 24 23:22:11 abit kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=32 


--
