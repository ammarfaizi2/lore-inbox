Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbSLDItI>; Wed, 4 Dec 2002 03:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbSLDItI>; Wed, 4 Dec 2002 03:49:08 -0500
Received: from denise.shiny.it ([194.20.232.1]:6597 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S266955AbSLDItI>;
	Wed, 4 Dec 2002 03:49:08 -0500
Message-ID: <XFMail.20021204095633.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20021204020838.GF3807@txc.com>
Date: Wed, 04 Dec 2002 09:56:33 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Igor Schein <igor@txc.com>
Subject: RE: performance of cache-intensive applications
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04-Dec-2002 Igor Schein wrote:
> Hi,
> 
> I am using an open-source application on ix86 to perform a task which
> is cache-intensive.  When I run consecutive iterations of the task on
> a fixed input, the variance in timing of each iteration is extemely
> high.   Needless to say, the test machine is always non-occupied.

CPU bound or I/O bound ?  What kernel version ?  IDE or
SCSI ?  vmstat ?  Other details ?


Bye.

