Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282891AbRK0Jgx>; Tue, 27 Nov 2001 04:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282892AbRK0Jgg>; Tue, 27 Nov 2001 04:36:36 -0500
Received: from quechua.inka.de ([212.227.14.2]:4623 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S282071AbRK0Jfm>;
	Tue, 27 Nov 2001 04:35:42 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.12 ... 2.4.16, /dev/tty
In-Reply-To: <XFMail.20011127085220.backes@rhrk.uni-kl.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E168eeJ-0005nt-00@calista.inka.de>
Date: Tue, 27 Nov 2001 10:35:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <XFMail.20011127085220.backes@rhrk.uni-kl.de> you wrote:
> still having problems (starting with kernel 2.4.12) with
> the /dev/tty device:

Do you have devfs? In that case the Devices are generated dynamically.

If you run ls on /dev/tty you should see an Entry with major 5 and minor
number 0.

Greetings
Bernd
