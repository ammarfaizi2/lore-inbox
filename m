Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293159AbSCJTGO>; Sun, 10 Mar 2002 14:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293163AbSCJTGF>; Sun, 10 Mar 2002 14:06:05 -0500
Received: from [202.54.124.178] ([202.54.124.178]:23977 "HELO
	mailFA9.rediffmail.com") by vger.kernel.org with SMTP
	id <S293159AbSCJTFy>; Sun, 10 Mar 2002 14:05:54 -0500
Date: 10 Mar 2002 17:22:27 -0000
Message-ID: <20020310172227.10392.qmail@mailFA9.rediffmail.com>
MIME-Version: 1.0
From: "tushar  korde" <tushar_k5@rediffmail.com>
Reply-To: "tushar  korde" <tushar_k5@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: kmalloc
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sir,
 	when i use kmalloc and kfree in a code the segmentation error 
comes
(though compilation was successful) but when i use vmalloc & vfree 
the same code runs fine.why?

my kernel version is 2.4.2-2
i included mm/slab.c & others for kmalloc
 		how to use kmalloc ?
