Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275725AbRJAXqA>; Mon, 1 Oct 2001 19:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275720AbRJAXpk>; Mon, 1 Oct 2001 19:45:40 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.11.31.247]:11137 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S275719AbRJAXph>; Mon, 1 Oct 2001 19:45:37 -0400
Message-ID: <3BB90039.E551000C@home.com>
Date: Mon, 01 Oct 2001 18:46:01 -0500
From: Jordan Breeding <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-ac1-preempt i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Increasing dmesg buffer size?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What kernel parameter do I need to modify in the source to allow a
larger dmesg buffer?  I have a lot of boot messages and I currently
loose about 10-20 lines immediately and they can not even be seen in
/var/log/dmesg because that file gets dumped after those lines are
already gone.  Thanks to anyone who can help.

Jordan Breeding
