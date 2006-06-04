Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751497AbWFDOdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWFDOdq (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 10:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWFDOdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 10:33:46 -0400
Received: from isilmar.linta.de ([213.239.214.66]:29645 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751497AbWFDOdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 10:33:45 -0400
Date: Sun, 4 Jun 2006 16:32:45 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-pcmcia@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [git pull] PCMCIA fixes for 2.6.17
Message-ID: <20060604143245.GA9363@dominikbrodowski.de>
Mail-Followup-To: torvalds@osdl.org, akpm@osdl.org,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull from

master.kernel.org:/pub/scm/linux/kernel/git/brodo/pcmcia-fixes-2.6.git/

The diffstat and list of changes follows; the patches will be sent out
individually to the linux-pcmcia list.

----
 drivers/char/pcmcia/cm4000_cs.c |    2 +-
 drivers/pcmcia/ds.c             |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
----
Dominik Brodowski:
      pcmcia: fix zeroing of cm4000_cs.c data

Florin Malita:
      pcmcia: missing pcmcia_get_socket() result check

