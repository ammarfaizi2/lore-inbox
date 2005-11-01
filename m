Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVKAJ2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVKAJ2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVKAJ2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:28:31 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:23580 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750702AbVKAJ2b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:28:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rIW5eNjVmuqc51BJres5P3a5UGopBQ/Hpnl6aL8iQ62oYFy3tlJ7rXGXqSxgkVopO8RJ7VZU5mb8dsxJH/fmMu/Fv5YfriGRRjGJEgBDL4J4E3cHICPYTPVHrUmCDP4ZgB/h0V+DqtXp6f5UCx/l8BX7pYVQZVA9/GThTjMj9QM=
Message-ID: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
Date: Tue, 1 Nov 2005 17:28:30 +0800
From: Luke Yang <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ADI Blackfin patch for kernel 2.6.14
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  This is the new Blackfin patch for kernel 2.6.14. Mainly includes
arch/Blackfin and include/asm-blackfin files. We decided not to put in
all the drivers for this version.

 Here is the patch URL:
 http://blackfin.uclinux.org/frs/download.php/606/bfin4kernel-2.6.14.patch
. Please reiview and merge it into the kernel. Thank you very much.

Luke Yang
luke.adi@gmail.com
ADI Inc.
