Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269643AbRHIAIu>; Wed, 8 Aug 2001 20:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269644AbRHIAIj>; Wed, 8 Aug 2001 20:08:39 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:1037 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269643AbRHIAIW>;
	Wed, 8 Aug 2001 20:08:22 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: kbuild-2.5 for 2.5.7-ac9 is available
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Aug 2001 10:08:28 +1000
Message-ID: <6761.997315708@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch from kbuild-2.5-2.4.8-pre6-1 to 2.4.7-ac9 is available on
http://sourceforge.net/projects/kbuild/, under Release 1.

Apply this patch in the following order.

  Kernel 2.4.7
  patch-2.4.7-ac9
  kbuild-2.5-2.4.8-pre6-1 from http://sourceforge.net/projects/kbuild/
  This patch

  It may or may not work, if it eats your system for breakfast, fix it
  and send patches to kbuild-devel@lists.sourceforge.net.  If you want
  a patch against a more recent -ac kernel and there is not one on
  sourceforge, upgrade the Makefile.in files yourself and send your
  updates to kbuild-devel.

