Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSFWTi2>; Sun, 23 Jun 2002 15:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317083AbSFWTi1>; Sun, 23 Jun 2002 15:38:27 -0400
Received: from hypatia.unh.edu ([132.177.137.23]:17157 "EHLO hypatia.unh.edu")
	by vger.kernel.org with ESMTP id <S317081AbSFWTi1>;
	Sun, 23 Jun 2002 15:38:27 -0400
Date: Sun, 23 Jun 2002 15:37:47 -0400 (EDT)
From: Qin Tao <qtao@cisunix.unh.edu>
X-X-Sender: qtao@hypatia.unh.edu
To: linux-kernel@vger.kernel.org
Subject: kernel taint
Message-ID: <Pine.OSF.4.44.0206231524160.455830-100000@hypatia.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using redhat7.3 (kernel 2.4.18-3). When I tried to insert a
kernel module, I got the following warning message:

"Warning: loading mymodule.o will taint the kernel: forced load"

I didn't see this problem when I inserted the module to some earlier
version kernels, such as 2.4.15. Does anybody know what does the warning
message mean and how can I modify my module code to avoid that?

Thanks in advance.

Qin

