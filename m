Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268412AbTCCHVN>; Mon, 3 Mar 2003 02:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268413AbTCCHVN>; Mon, 3 Mar 2003 02:21:13 -0500
Received: from franka.aracnet.com ([216.99.193.44]:22731 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268412AbTCCHVM>; Mon, 3 Mar 2003 02:21:12 -0500
Date: Sun, 02 Mar 2003 23:31:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Prasad <prasad_s@students.iiit.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: redirecting printk to the Serial port
Message-ID: <96100000.1046676676@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0303031255570.27683-100000@students.iiit.net>
References: <Pine.LNX.4.44.0303031255570.27683-100000@students.iiit.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, March 03, 2003 12:58:24 +0530 Prasad <prasad_s@students.iiit.net> wrote:

> 
> 
> I have seen the Documentation/serial-console.txt and accordingly gave the 
> kernel arguments console=/dev/ttyS0,9600n8, but even after giving that i 
> am not getting anything to the other end. To check if the serial 
> communication was in place... i tried echo "abc" > /dev/ttyS0 and that 
> worked.

I use "console=ttyS0,57600n8" - no "/dev".

M.

