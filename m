Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266504AbSIRNBz>; Wed, 18 Sep 2002 09:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266525AbSIRNBz>; Wed, 18 Sep 2002 09:01:55 -0400
Received: from goliath.sylaba.poznan.pl ([195.216.104.3]:15825 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id <S266504AbSIRNBy>; Wed, 18 Sep 2002 09:01:54 -0400
Subject: Which processor/board for embedded NTP
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 18 Sep 2002 15:10:32 +0200
Message-Id: <1032354632.23252.14.camel@venus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have to build NTP server on an embedded pc.
Which processors/boards are suitable for this.
Such processor/board cannot have ANY problems with time handling.
I thought about Geode (NS), but I found some info that it doesn't have
TSC, or it works not properly (the PPS needs TSC). 
And of course has to work excellent with linux.

Please CC me, as I'm not subscribed.

Best Regards,

Olaf Fraczyk





