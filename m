Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312975AbSDKV2n>; Thu, 11 Apr 2002 17:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312977AbSDKV2m>; Thu, 11 Apr 2002 17:28:42 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:24071
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S312975AbSDKV2m>; Thu, 11 Apr 2002 17:28:42 -0400
Subject: ANNOUNCEMENT: 2.4.19-pre6-rmap-12i-xfs-shawn11 released
From: Shawn Starr <spstarr@sh0n.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 11 Apr 2002 17:28:20 -0400
Message-Id: <1018560530.356.0.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a stable release. Please test: 

xfs-2.4.19-pre6-rmap-12i-shawn11 against 2.4.18 vanilla, (April 10th,
2002) 

Contains: 

2.4.19-pre6                     (Marcelo Tosatti) 
rmap-12i                        (Rik van Riel 
                                 William Lee Irwin III) 

April 10th, XFS CVS             (me) 

*NOTE: 2.4.19-pre5-ac3 does *NOT* boot my system I get swapper kernel
panic. -ac is out for now. 

*IDE taskfile IO was merged into the later 2.4.19 pre kernels. 

* There are significant Quota problems with current -ac patch and XFS
quota. I should hopefully have this working in -shawn12 but I need a
working -ac patch to boot from ;) 

You can find all my patches at http://xfs.sh0n.net/2.4




