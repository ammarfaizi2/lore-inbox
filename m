Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129275AbRBCXiF>; Sat, 3 Feb 2001 18:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130581AbRBCXhz>; Sat, 3 Feb 2001 18:37:55 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:37810 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129275AbRBCXhv>; Sat, 3 Feb 2001 18:37:51 -0500
Message-ID: <3A7C9638.63C513D0@Home.net>
Date: Sat, 03 Feb 2001 18:37:28 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PS hanging in 2.4.1 - More interesting things
In-Reply-To: <3A7C8AC4.D3CAAF57@Home.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I rebooted the system, then syslogd was using 100% cpu?

it seems like perhaps reiserfs is causing this problem??



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
