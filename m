Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVDRHeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVDRHeL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 03:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVDRHeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 03:34:10 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:57449 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261855AbVDRHeB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 03:34:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=myblfzGbnA5aeJ+fDJuEJI86eRskhXugK6kclw1ykDAAnMoRIf86vZrTRSwvOnydUoM1dh5fn3+tPm1mQ3GNFFoq2yqaCuKUBJzMIAco1H6qgLJNKqtlFm7WMhwueUZhAjJ61KQUxlNvMejZV07bPJkw++xY1kQ9m+HRfnIa0Mo=
Message-ID: <6596a01050418003335ab6cf6@mail.gmail.com>
Date: Mon, 18 Apr 2005 00:33:57 -0700
From: Ashmi Bhanushali <ashmib@gmail.com>
Reply-To: Ashmi Bhanushali <ashmib@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: a networking question
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all..

i m a new bee in lunix kernel. and i m trying to implement "FIFO+"
queuing for packet forwarding in linux kernel by modifying the
original code for packet forwarding(FIFO).

i m going to use fedora core 2 and the kernel version is 2.6.11-7. i
nned some help to locate the original code of queuing (FIFO). I looked
at some files like ip_input.c, ip_output.c and ip_forward.c in the
net/ipv4 directory of the kernel source code. but i m not sure if
these are the correct files to look for the original FIFO packet
queuing implemented in linux kernel.

could someone please help me in locating the files which has the FIFO
queuing code.

thanks in advance.

-ashmi
