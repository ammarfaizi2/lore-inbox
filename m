Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275624AbRIZV3h>; Wed, 26 Sep 2001 17:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275622AbRIZV31>; Wed, 26 Sep 2001 17:29:27 -0400
Received: from [213.97.199.90] ([213.97.199.90]:4736 "HELO fargo")
	by vger.kernel.org with SMTP id <S275621AbRIZV3P> convert rfc822-to-8bit;
	Wed, 26 Sep 2001 17:29:15 -0400
From: "David =?ISO-8859-1?Q?G=F3mez" ?= <davidge@jazzfree.com>
Date: Wed, 26 Sep 2001 23:27:17 +0200 (CEST)
X-X-Sender: <huma@fargo>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: reparent_to_init
Message-ID: <Pine.LNX.4.33.0109262324150.2312-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, this is another report of the error that some people seems to have
with 2.4.10 kernel. This message appears on my syslog:

Sep 26 21:34:41 fargo kernel: task `ifconfig' exit_signal 17 in
reparent_to_init

I'm using the 8139too.c driver.


David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


