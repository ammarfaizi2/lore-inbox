Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbQLNDlj>; Wed, 13 Dec 2000 22:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129824AbQLNDl3>; Wed, 13 Dec 2000 22:41:29 -0500
Received: from dagon.host4u.net ([209.150.128.152]:55050 "EHLO
	dagon.host4u.net") by vger.kernel.org with ESMTP id <S129730AbQLNDlN>;
	Wed, 13 Dec 2000 22:41:13 -0500
Date: Thu, 14 Dec 2000 04:11:09 +0100
From: Ivan Vadovic <pivo@pobox.sk>
To: linux-kernel@vger.kernel.org
Subject: IP ID == 0 ?!
Message-ID: <20001214041109.A997@ivan.doma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been having weird problems with 2.4 kernels ip networking. I can't connect
to several sites ( hotmail.com,intel.com... ). After some investigation with
tcpdump I figured that the IDentification field of every outgoing ip packet is
set to zero and then it doesn't get through some few firewalls. I'm surprised
I haven't found anything about it in the list archives, so I'm trying to get
help here. Did I forget to configure something?

Ivan Vadovic
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
