Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265402AbTFVSqG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265453AbTFVSqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:46:06 -0400
Received: from mail.ithnet.com ([217.64.64.8]:12306 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265402AbTFVSqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:46:02 -0400
Date: Sun, 22 Jun 2003 21:00:18 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy TARREAU <willy@w.ods.org>
Cc: willy@w.ods.org, marcelo@conectiva.com.br, kpfleming@cox.net,
       stoffel@lucent.com, gibbs@scsiguy.com, linux-kernel@vger.kernel.org,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030622210018.03eb4e0a.skraw@ithnet.com>
In-Reply-To: <20030621105019.GA834@pcw.home.local>
References: <20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<20030621105019.GA834@pcw.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

here is the interesting result of my working weekend with intensive testing:
As 22-pre1 just came out I decided to use it for further testing of the issue,
because I don't like testing old kernels particularly. And to my great surprise
I have not managed to break 22-pre1 so far. I have up to now moved about 1 TB
of data through the box (written to tape and verified) and have not yet
produced a single verify error.
Question is: how do I continue?
Of course the tape-writing actions will be continuing, so I still have a look
at the issue every day.
Are we interested in finding out what particular patch in pre1 is responsible
for this?

Well, at least there is the positive result that pre1 seems significantly
better...

Regards,
Stephan
