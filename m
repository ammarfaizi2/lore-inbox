Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269822AbRHMF1T>; Mon, 13 Aug 2001 01:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269819AbRHMF1J>; Mon, 13 Aug 2001 01:27:09 -0400
Received: from [216.6.80.34] ([216.6.80.34]:29967 "EHLO
	dcmtechdom.dcmtech.co.in") by vger.kernel.org with ESMTP
	id <S269822AbRHMF1A>; Mon, 13 Aug 2001 01:27:00 -0400
Message-ID: <7FADCB99FC82D41199F9000629A85D1A01C6510F@dcmtechdom.dcmtech.co.in>
From: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Reg System.map file 
Date: Mon, 13 Aug 2001 10:58:15 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check /proc/ksyms, you will find the addresses of your 
as well as kernel's exported functions.......

Regards,
Nitin

On Mon, 13 Aug 2001 10:52:42 +0530 (IST), 
"SATHISH.J" <sathish.j@tatainfotech.com> wrote:
>Does the System.map file contain only the addresses of kernel functions
>present at the boot time. What I mean is, suppose I insert a new driver
>into the kernel, Is there any way to show its addresses in the System.map
>file? Please help me out with this.

