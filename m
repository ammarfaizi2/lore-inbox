Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263469AbRFMVlX>; Wed, 13 Jun 2001 17:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263886AbRFMVlN>; Wed, 13 Jun 2001 17:41:13 -0400
Received: from comverse-in.com ([38.150.222.2]:51934 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S263469AbRFMVlC>; Wed, 13 Jun 2001 17:41:02 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678F59@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'stimits@idcomm.com'" <stimits@idcomm.com>
Cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: RE: bzDisk compression Q; boot debug Q
Date: Wed, 13 Jun 2001 17:39:57 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Question 2, apparently ramdisk uses gzip compression; the name of the
> kernel from make bzImage seems to maybe refer to bzip2 compression. Is
> the kernel image using gzip or bzip2 compression for bzImage? Would
bzImage stands for "big zImage" - this is a format invented for kernels that
don't fit into zImage. bzip2 has nothing to do with it :)
