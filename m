Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281812AbRKWIyj>; Fri, 23 Nov 2001 03:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281815AbRKWIya>; Fri, 23 Nov 2001 03:54:30 -0500
Received: from etna.trivadis.com ([193.73.126.2]:12792 "EHLO lttit")
	by vger.kernel.org with ESMTP id <S281814AbRKWIyY>;
	Fri, 23 Nov 2001 03:54:24 -0500
Date: Fri, 23 Nov 2001 09:51:22 +0100
From: Tim Tassonis <timtas@cubic.ch>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: 2.4.15-greased-turkey ???
X-Mailer: Sylpheed version 0.6.5cvs13 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E167C3O-00028a-00@lttit>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

linux/include/linux/version.h in 2.4.15:

#define UTS_RELEASE "2.4.15-greased-turkey"
#define LINUX_VERSION_CODE 132111
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))


What's this all about??

(Looks a bit strange to have /lib/modules/2.4.15-greased-turkey ...)

Bye
Tim
