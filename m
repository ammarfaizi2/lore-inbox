Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268402AbTCCHLK>; Mon, 3 Mar 2003 02:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268405AbTCCHLK>; Mon, 3 Mar 2003 02:11:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:51645 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268402AbTCCHLJ>; Mon, 3 Mar 2003 02:11:09 -0500
Date: Sun, 02 Mar 2003 23:20:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Prasad <prasad_s@students.iiit.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: redirecting printk to the Serial port
Message-ID: <95740000.1046676056@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0303031242150.24054-100000@students.iiit.net>
References: <Pine.LNX.4.44.0303031242150.24054-100000@students.iiit.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Got a silly doubt. when trying to insert one of my modules into
> the kernel, its getting rebooted and unfortunately i am losing all the
> debug(printk) messages.  Can i in some fashion capture all the printk's
> through the serial port. (I have two linux boxes and a serial cable to
> connect both of them)

See Documentation/serial-console.txt

M.

