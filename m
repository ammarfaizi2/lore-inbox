Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281275AbRKLG3U>; Mon, 12 Nov 2001 01:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281281AbRKLG3L>; Mon, 12 Nov 2001 01:29:11 -0500
Received: from [196.28.7.2] ([196.28.7.2]:47530 "HELO netfinity.realnet.co.sz")
	by vger.kernel.org with SMTP id <S281275AbRKLG27>;
	Mon, 12 Nov 2001 01:28:59 -0500
Date: Mon, 12 Nov 2001 08:38:29 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <linux-kernel@vger.kernel.org>
Cc: <steve@uhura.rueb.com>
Subject: Best kernel config for exactly 1GB ram 
Message-ID: <Pine.LNX.4.33.0111120830140.1901-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you actually lose about 128Mb ram (128Mb HIGHMEM) if you don't specify the
4gig option, and you might find that you'd rather have the extra memory
than the "noticeable?" slowdown. I set all my 1G boxes to 4G mostly because
i put that amount of ram because i need every bit.

Regards,
	Zwane Mwaikambo

