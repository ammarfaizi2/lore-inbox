Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbQLRFyf>; Mon, 18 Dec 2000 00:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbQLRFyZ>; Mon, 18 Dec 2000 00:54:25 -0500
Received: from bootp-83.newpem.brown.edu ([128.148.214.83]:53764 "HELO
	delta.brown.edu") by vger.kernel.org with SMTP id <S129534AbQLRFyW>;
	Mon, 18 Dec 2000 00:54:22 -0500
Message-ID: <3A3D9F7A.40F1004@brown.edu>
Date: Mon, 18 Dec 2000 00:24:10 -0500
From: David Feuer <David_Feuer@brown.edu>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: APM/DPMS lockup on Dell 3800
In-Reply-To: <3A3D9AE2.8721062F@brown.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>

By the way, I now checked the syslog, and I see that the last cron message
was logged about an hour before I reset the system.  So it looks like a total
lockup.


BTW, what does it mean when this gets logged?

Dec 17 19:01:09 localhost kernel: eth0: Resetting the Tx ring pointer.
Dec 17 19:01:09 localhost kernel: eth0: Tx Ring full, refusing to send
buffer.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
