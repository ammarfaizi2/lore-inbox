Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272037AbRHVQCD>; Wed, 22 Aug 2001 12:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272039AbRHVQBy>; Wed, 22 Aug 2001 12:01:54 -0400
Received: from allegro.ethz.ch ([129.132.112.3]:65284 "EHLO allegro.ethz.ch")
	by vger.kernel.org with ESMTP id <S272037AbRHVQBr>;
	Wed, 22 Aug 2001 12:01:47 -0400
Date: Wed, 22 Aug 2001 18:01:54 +0200
From: Christian Jaeger <christian.jaeger@sl.ethz.ch>
To: linux-kernel@vger.kernel.org
Subject: Rawio and mirroring (sw raid)
Message-Id: <20010822180154.7528f496.christian.jaeger@sl.ethz.ch>
X-Mailer: Sylpheed version 0.5.0 (GTK+ 1.2.8; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I'm missing any documentation of raw devices. I even haven't found the source of the `raw' userland tool(s). Any pointer?
Is it possible to mirror partitions accessed through unbuffered/raw io?

christian
