Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265871AbUEUN3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUEUN3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 09:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265873AbUEUN3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 09:29:08 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:55622 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265871AbUEUN3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 09:29:05 -0400
Message-ID: <bffbecbb0405210629414700f9@mail.gmail.com>
Date: Fri, 21 May 2004 14:29:04 +0100
From: Phillip Lougher <phillip.lougher@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [announce] Squashfs2.0-alpha released (compressed filesystem)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm pleased to announce the first version of Squashfs 2.0.  A lot of
changes to the Squashfs filesystem have been made under the bonnet
(hood), to improve compression. Squashfs 2.0 has added the concept of
fragment blocks and has increased the block size to 64K. This achieves
a 5 - 20% compression saving, and allows Squashfs to achieve better
compression than Cloop while retaining the I/O efficiency of a
compressed filesystem.  In addition, the maximum number of UIDs and
GIDs has been increased to 256. This allows Squashfs to better support
live CDs.

For a description of fragment blocks and the other changes, please go
to the project page http://squashfs.sourceforge.net.

Regards

Phil Lougher
