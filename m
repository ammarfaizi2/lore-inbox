Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261534AbSJMPQF>; Sun, 13 Oct 2002 11:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSJMPQF>; Sun, 13 Oct 2002 11:16:05 -0400
Received: from ns.ithnet.com ([217.64.64.10]:12811 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261534AbSJMPQE>;
	Sun, 13 Oct 2002 11:16:04 -0400
Date: Sun, 13 Oct 2002 17:21:38 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: nfs-server slowdown in 2.4.20-pre10 with client 2.2.19
Message-Id: <20021013172138.0e394d96.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Trond, 
hello all,

just to drop a note: I am experiencing a rather dramatic slowdown of the
nfs-server in kernel 2.4.20-pre10 in conjunction with nfs-clients kernel
2.2.19. To be more specific, the server is a SMP machine and runs always the
latest 2.4.x  kernels. Upto 2.4.20-pre9 everything was quite ok, but pre10
brought an incredible loss. The setup did not change, only the kernel on the
server side. Merely all nfs action is writing to the server, reading from it is
next to zero in this setup.
-- 
Regards,
Stephan
