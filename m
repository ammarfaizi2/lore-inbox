Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266562AbTGFAJx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 20:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266570AbTGFAJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 20:09:52 -0400
Received: from smtp.terra.es ([213.4.129.129]:51533 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S266562AbTGFAJw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 20:09:52 -0400
Date: Sun, 6 Jul 2003 02:23:25 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-Id: <20030706022325.4ef87afc.diegocg@teleline.es>
In-Reply-To: <200307060131.02051.phillips@arcor.de>
References: <20030703023714.55d13934.akpm@osdl.org>
	<200307052309.12680.phillips@arcor.de>
	<20030706001136.3a423b29.diegocg@teleline.es>
	<200307060131.02051.phillips@arcor.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 6 Jul 2003 01:31:02 +0200 Daniel Phillips <phillips@arcor.de>
escribió:

> It does.  It requires realtime scheduling.  That is special.  Without
> realtime scheduling, the mp3 player will sometimes miss its deadline for
> filling the next chunk of buffer.

It'll do if you're running oracle at the same time.

Desktop users shouldn't notice skips.




Diego Calleja
