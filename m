Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266497AbSKZSnE>; Tue, 26 Nov 2002 13:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbSKZSnD>; Tue, 26 Nov 2002 13:43:03 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:14863 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266497AbSKZSnC>; Tue, 26 Nov 2002 13:43:02 -0500
Subject: Compiler & Statically Linked Question
From: "Richard B. Tilley " "(Brad)" <rtilley@vt.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Nov 2002 13:50:19 -0500
Message-Id: <1038336619.7793.28.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to start running some of the 2.5.x kernels for testing
purposes on a wide selection (about 12 machines) of Intel x86 PCs that I
have collected for testing purposes.

I would like to have one build machine where I build a kernel and then
use that kernel on all of the test PCs. I do not want to build a kernel
for each machine.

The PCs have very different hardware and I'd like to play around with
different c libraries on these PCs. So, what would be the best way to
build a kernel that would work in this type of environment?

Thank you,

Brad


