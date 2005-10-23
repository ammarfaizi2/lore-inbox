Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbVJWJC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVJWJC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 05:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVJWJC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 05:02:59 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:24977 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751439AbVJWJC7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 05:02:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NpqROjY/mYRtK0lkX0PkKEtR13tWD/Klomb20NDbiKB8senz+hW4bx5frnyQCYp9BtGhZvqTmNvUMLBCcGf4F5HirsXW+dJJxuh+iWxmqu/QHp9VdPq5KGbDqoRR+Wi13OhmbeVcq0o/rdv0vV0AlgysuR/y3dhLIxIeZ3SoB7s=
Message-ID: <1e33f5710510230202q2623ff61w275e2aabac72b0a6@mail.gmail.com>
Date: Sun, 23 Oct 2005 14:32:58 +0530
From: Gaurav Dhiman <gaurav4lkg@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Problem]: accessing Marvell LAN card (sk98lin.ko)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Toshiba M55 325 Laptop, which have Marvell 10/100 Base-TX
Ethernet card. I think the driver for this is sk98lin.ko, I am also
successful in loading that (saw lsmod). After loading when I do 'ls
/proc/net/sk98lin/' , it does not show me anything.

I am not able to understand how can I access the network card, what
device file I need to use for that ? When I do ifconfig, it only shows
me the loopback interface.

Looking for any healp on this.

regards,
--
- Gaurav
my blog: http://lkdp.blogspot.com/
--
