Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbUBYTOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUBYTOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:14:50 -0500
Received: from smtp1.home.se ([213.214.194.101]:39942 "EHLO smtp1.home.se")
	by vger.kernel.org with ESMTP id S262511AbUBYTNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:13:53 -0500
Date: Wed, 25 Feb 2004 20:15:59 +0000
From: Albert =?ISO-8859-1?Q?Hafvenstr=F6m?= <albhaf@home.se>
To: linux-kernel@vger.kernel.org
Subject: Unable to mount root fs
Message-Id: <20040225201559.410a385c.albhaf@home.se>
Organization: SSB
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error when I tried to boot a newly compiled 2.6.3-kernel:

Kernel Panic: VFS: Unbale to mount root fs on hdb1

As I have a 2.4.23 kernel with the same boot options it must be some settings in the kernel, right?

/albhaf
