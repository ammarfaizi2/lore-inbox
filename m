Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUKAOtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUKAOtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267645AbUKAOta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:49:30 -0500
Received: from smtp.terra.es ([213.4.129.129]:62805 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S267613AbUKAOtQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:49:16 -0500
Date: Mon, 1 Nov 2004 15:48:53 +0100
From: Diego Calleja <diegocg@teleline.es>
To: Z Smith <plinius@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
Message-Id: <20041101154853.6b393f8a.diegocg@teleline.es>
In-Reply-To: <418550C1.1060203@comcast.net>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	<200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
	<1099170891.1424.1.camel@krustophenia.net>
	<200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
	<1099175138.1424.18.camel@krustophenia.net>
	<20041031150637.6311a2ec.diegocg@teleline.es>
	<418550C1.1060203@comcast.net>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 31 Oct 2004 12:53:21 -0800 Z Smith <plinius@comcast.net> escribió:

> But not everyone can tolerate today's level of bloat.

Sadly it's true, but in the other hand I haven't seen something like gnome/kde
which don't eats lots of resources (mac os x and XP are not better, beos was
better they say), which makes me think that building a  desktop environment
without eating lots of resources is not easy. Well, and your projct is also
bloat in some ways...it's small and all that but putting a graphics system
inside the kernel is one of the best definitions of "bloat" you can find...
