Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131708AbRCTDa5>; Mon, 19 Mar 2001 22:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131709AbRCTDar>; Mon, 19 Mar 2001 22:30:47 -0500
Received: from kiln.isn.net ([198.167.161.1]:31533 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S131708AbRCTDaa>;
	Mon, 19 Mar 2001 22:30:30 -0500
Message-ID: <3AB6CE54.90C402C9@isn.net>
Date: Mon, 19 Mar 2001 23:28:20 -0400
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3-pre4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: gcc-3.0 and abs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

usb audio uses the abs function, which is no longer included in gcc-3.0
Not a big deal yet, since the kernel crashes with it anyway, but
something to
look at.
Garst
