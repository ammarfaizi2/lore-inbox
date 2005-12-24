Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVLXPKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVLXPKo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 10:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVLXPKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 10:10:44 -0500
Received: from lucidpixels.com ([66.45.37.187]:51596 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750786AbVLXPKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 10:10:44 -0500
Date: Sat, 24 Dec 2005 10:10:27 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Tape Drive Question (2.6.14.4)
Message-ID: <Pine.LNX.4.64.0512241009230.2904@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ ls -l /dev/st0*
crw-rw-rw-  1 root tape 9,  0 2004-09-18 07:51 /dev/st0
crw-rw-rw-  1 root tape 9, 96 2004-09-18 07:51 /dev/st0a
crw-rw-rw-  1 root tape 9, 32 2004-09-18 07:51 /dev/st0l
crw-rw-rw-  1 root tape 9, 64 2004-09-18 07:51 /dev/st0m

What differentiates st0 from a,l,m?
What does writing or reading to a tape using a,l,m signify?

I cannot seem to find any documentation clearly stating this.

Justin.
