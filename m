Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273831AbRJEWCM>; Fri, 5 Oct 2001 18:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273888AbRJEWCD>; Fri, 5 Oct 2001 18:02:03 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:4359 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S273831AbRJEWBx>; Fri, 5 Oct 2001 18:01:53 -0400
From: llx@swissonline.ch
Message-Id: <200110052202.f95M2Ig16051@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
Reply-To: llx@swissonline.ch
To: linux-kernel@vger.kernel.org
Subject: proc file system
Date: Sat, 6 Oct 2001 00:02:18 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've written a prog interface for my logger utility to make it easy
to transport my logging information from kernel to userspace using
shell commands. now i want to use tail -f /prog/<mylogfile>. what
do i have to do for that to work. when using tail my loginfo gets
read form my ringbuffer, but nothing gets printed in the terminal.
