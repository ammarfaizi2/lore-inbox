Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292384AbSB0OSP>; Wed, 27 Feb 2002 09:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292508AbSB0OSH>; Wed, 27 Feb 2002 09:18:07 -0500
Received: from x86unx3.comp.nus.edu.sg ([137.132.90.3]:38305 "EHLO
	x86unx3.comp.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S292395AbSB0OR5>; Wed, 27 Feb 2002 09:17:57 -0500
Date: Wed, 27 Feb 2002 22:17:51 +0800 (GMT-8)
From: Zhu Ying Jie <zhuyingj@comp.nus.edu.sg>
To: linux-kernel@vger.kernel.org
Subject: How to disable TCP's checksum
Message-ID: <Pine.GSO.4.21.0202272215080.21508-100000@sf3.comp.nus.edu.sg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I am currently using kernel version 2.4.2 and trying to disable
tcp_input's checksum function. However, even I comment all the csum_error
in the file tcp_input.c, the packet (with wrong checksum) seems still will
be dropped. Can anyone tell me how to do the work? 

Zhu Ying jie
Department of Computer Science,
School of Computing, 
National University of Singapore


SS****************************SS***********************************SS
+           From little town of far land we came,                   + 
+           to save our honor from a world of flame.                +
+           By little town of far land we sleep,                    + 
+           and trust that world will be won for you to keep.       +
SS****************************SS***********************************SS


