Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274750AbRJAIUo>; Mon, 1 Oct 2001 04:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274752AbRJAIUe>; Mon, 1 Oct 2001 04:20:34 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:10254 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S274750AbRJAIUX>; Mon, 1 Oct 2001 04:20:23 -0400
Subject: 2.4.11-pre1 -- Error in ./Changes -- Wrong location given to
	retrieve the latest Mkinitrd
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99 (Preview Release)
Date: 01 Oct 2001 01:13:01 -0700
Message-Id: <1001923986.17172.54.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Changes document gives the following mkinitrd information:

Mkinitrd
--------
o  <ftp://rawhide.redhat.com/pub/rawhide/SRPMS/SRPMS/>

However, rawhide.redhat.com/pub/rawhide no longer exists.
The current directory listing for pub is:

contrib/    .private/   redhat/     .snapshot/  up2date/

I've searched the web quite a bit and have failed to find
an authoritative distribution location.

	Miles

