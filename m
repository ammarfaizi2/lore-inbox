Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275315AbTHGM2w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275317AbTHGM2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:28:52 -0400
Received: from alpha.cpe.ku.ac.th ([158.108.32.31]:9669 "EHLO
	alpha.cpe.ku.ac.th") by vger.kernel.org with ESMTP id S275315AbTHGM2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:28:51 -0400
Date: Thu, 7 Aug 2003 19:28:46 +0700 (ICT)
From: Theewara Vorakosit <g4685034@alpha.cpe.ku.ac.th>
To: <linux-kernel@vger.kernel.org>
Subject: sendfile system call on tmpfs
Message-ID: <Pine.LNX.4.33.0308071831240.16498-100000@alpha.cpe.ku.ac.th>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
	I use linux redhat 9 with kernal 2.4.20-13.9smp. I try to use
sendfile system. I found that on ext3 file system, it works fine.
However, on tmpfs, it error with "Invalid argument". Does sendfile()
support on tmpfs or other filesystem?
Thanks,
Theewara

