Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283942AbRLAE4N>; Fri, 30 Nov 2001 23:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283937AbRLAEux>; Fri, 30 Nov 2001 23:50:53 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62358 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S283919AbRLAEub>;
	Fri, 30 Nov 2001 23:50:31 -0500
Message-ID: <3C085B04.50ABE0B5@starband.net>
Date: Fri, 30 Nov 2001 23:22:28 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is it normal for freezing while...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it normal for a system to lockup while creating a 3GB test file?

Following command: dd if=/dev/zero of=file bs=1M count=3000

The system freezes up for 30-60 seconds for as many as 3-4 times during
the creation of the file.

Is this normal?
Anyway to tweak the /proc settings to avoid system freezing?



