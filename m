Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbTFWWmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbTFWWmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:42:00 -0400
Received: from lgsx13.lg.ehu.es ([158.227.2.28]:45041 "EHLO lgsx13.lg.ehu.es")
	by vger.kernel.org with ESMTP id S265500AbTFWWl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:41:58 -0400
Date: Tue, 24 Jun 2003 01:09:06 +0200
From: Luis Miguel Garcia <ktech@wanadoo.es>
To: linux-kernel@vger.kernel.org
Subject: Kernel & BIOS return differing head/sector geometries
Message-Id: <20030624010906.08ad32f3.ktech@wanadoo.es>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

I'm getting this while running lilo from kernel 2.5.72mm2. What does it means?

Could it be dangerous?

Thanks.



bash-2.05b# lilo
Warning: Kernel & BIOS return differing head/sector geometries for device 0x80
    Kernel: 13424 cylinders, 15 heads, 63 sectors
      BIOS: 788 cylinders, 255 heads, 63 sectors
Added 2572mm2
Added 2573desktop
Added 2421-ck1 *

