Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266053AbTIJXlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbTIJXlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:41:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:31906 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266053AbTIJXlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:41:16 -0400
Date: Wed, 10 Sep 2003 16:41:05 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: <linux-kernel@vger.kernel.org>
cc: <plm-devel@lists.sourceforge.net>
Subject: PowerPC Cross-compile of 2.6 kernels 
Message-ID: <Pine.LNX.4.33.0309101629260.24847-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In response to requests at OLS, we've added cross-compile
capability to the PLM, and the first architecture
implemented is PowerPC.  The powerpc code is
generated via a cross-compiler set up using Dan
Kegels's crosstool-0.22 on an i386 host using gcc-3.3.1,
glibc-2.3.2 and built for the powerpc-750.

The filter run is the compile regress developed by John
Cherry at OSDL.  Refer to his prior mail on lkml for the
results of this filter on ia386 and IA64.

Look at
    http://www.osdl.org/plm-cgi/plm?module=search
and look up linux-2.6.0-test5 or any later kernels for the
results of this filter under 'PPC-Cross Compile Regress'.

Does anyone have any input regarding requests for
additional architectures or improvements to the
filters?  Please cc me in any responses to lkml as I do
not currently monitor this list, though other OSDL
employees do.

Thanks;

Judith Lebzelter
OSDL


