Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268488AbUJJUwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268488AbUJJUwm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 16:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUJJUwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 16:52:42 -0400
Received: from goliath.sylaba.poznan.pl ([193.151.36.3]:36625 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id S268488AbUJJUwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 16:52:41 -0400
Subject: How to umount a busy filesystem?
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1097441558.2235.9.camel@venus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 10 Oct 2004 22:52:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Why I cannot umount filesystem if it is being accessed?
I tried MNT_FORCE option but it doesn't work.

Killing all processes that access a filesystem is not an option. They
should just get an error when accessing filesystem that is umounted.

Any idea how to do it?

Please CC me.

Regards,

Olaf Fraczyk

