Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbRGRPjw>; Wed, 18 Jul 2001 11:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbRGRPjn>; Wed, 18 Jul 2001 11:39:43 -0400
Received: from [213.97.45.174] ([213.97.45.174]:14867 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S267490AbRGRPja>;
	Wed, 18 Jul 2001 11:39:30 -0400
Date: Wed, 18 Jul 2001 17:39:26 +0200 (CEST)
From: Pau <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: <linux-kernel@vger.kernel.org>
Subject: Zombies in 2.4.6-ac[45]
Message-ID: <Pine.LNX.4.33.0107181734550.15055-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.4.6-ac4 and 2.4.6-ac5 I keep on getting processes in Z state, mainly
identd (spawned from an identd daemon) and galeon (the gnome browser).
An strace to the process ends immediately. I've had almost 300 Z processes
only in galeon.

Any explanation? Any help to trace it?

Pau

