Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272092AbRI0IjJ>; Thu, 27 Sep 2001 04:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272118AbRI0Ii7>; Thu, 27 Sep 2001 04:38:59 -0400
Received: from [213.97.199.90] ([213.97.199.90]:3200 "HELO fargo")
	by vger.kernel.org with SMTP id <S272092AbRI0Iiq> convert rfc822-to-8bit;
	Thu, 27 Sep 2001 04:38:46 -0400
From: "David =?ISO-8859-1?Q?G=F3mez" ?= <davidge@jazzfree.com>
Date: Thu, 27 Sep 2001 10:36:47 +0200 (CEST)
X-X-Sender: <huma@fargo>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: version.h
Message-ID: <Pine.LNX.4.33.0109271032320.4588-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that in 2.4.10 include/linux/version.h has not updated the macro
UTS_VERSION to the new kernel version. I found this error when trying to
compile alsa-drivers and the configure script couldn't find the right
modules directory.


David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


