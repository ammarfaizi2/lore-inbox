Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTKLIqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 03:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTKLIqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 03:46:30 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:6619 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261188AbTKLIq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 03:46:29 -0500
X-Sender-Authentication: net64
Date: Wed, 12 Nov 2003 09:46:27 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: 2.4.23-rc1 messages
Message-Id: <20031112094627.31060ca7.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just encountered the following message:

Nov 12 01:00:10 box kernel: sd(8,17):vs-13075: reiserfs_read_inode2: dead inode read from disk [114 635405 0x0 SD]. This is likely to be race with knfsd. Ignore

I have never seen such output before on this box... 
Is this message interesting for anybody?

Regards,
Stephan
