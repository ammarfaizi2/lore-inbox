Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbRBBBdl>; Thu, 1 Feb 2001 20:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130276AbRBBBdc>; Thu, 1 Feb 2001 20:33:32 -0500
Received: from topaz.3com.com ([192.156.136.158]:36599 "EHLO topaz.3com.com")
	by vger.kernel.org with ESMTP id <S129814AbRBBBdR>;
	Thu, 1 Feb 2001 20:33:17 -0500
X-Lotus-FromDomain: 3COM
From: Jagan_Pochimireddy@3com.com
To: Prasanna P Subash <psubash@turbolinux.com>
cc: linux-kernel@vger.kernel.org
Message-ID: <882569E7.0008ABE1.00@hqoutbound.ops.3com.com>
Date: Thu, 1 Feb 2001 17:34:58 -0800
Subject: Re: kernel ver 2.4.1 VFS problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



That problem solved by compiling the correct SCSI driver into the kernel. Now it
is the problem with input console. It says Unable to open Input console. This is
after mounting VFS.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
