Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268121AbUIPTGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbUIPTGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 15:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUIPTGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 15:06:49 -0400
Received: from ozlabs.org ([203.10.76.45]:10127 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268182AbUIPTGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 15:06:45 -0400
Date: Fri, 17 Sep 2004 05:06:33 +1000
From: Anton Blanchard <anton@samba.org>
To: hugh@veritas.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: tmpfs in latest BK
Message-ID: <20040916190633.GG2825@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just gave BK a try on my ppc32 laptop and tmpfs looks to be playing up:

# mount -t tmpfs none /mnt
# ls /mnt
ls: mnt: Not a directory

Does this ring any bells? :)

Anton
