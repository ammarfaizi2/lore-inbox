Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135302AbRAGCOs>; Sat, 6 Jan 2001 21:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135515AbRAGCOi>; Sat, 6 Jan 2001 21:14:38 -0500
Received: from ANancy-101-1-1-133.abo.wanadoo.fr ([193.251.70.133]:48116 "HELO
	the-babel-tower.nobis.phear.org") by vger.kernel.org with SMTP
	id <S135302AbRAGCO2>; Sat, 6 Jan 2001 21:14:28 -0500
Date: Sun, 14 Jan 2001 03:20:52 +0100 (CET)
From: Nicolas Noble <Pixel@the-babel-tower.nobis.phear.org>
To: "Linux-kernel's Mailing list" <linux-kernel@vger.kernel.org>
Subject: Little question about modules...
Message-ID: <Pine.LNX.4.21.0101140318240.5780-100000@the-babel-tower.nobis.phear.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a question:

Why do I have used by -1 for the module ipv6 onto my system?

extract of the /proc/modules:

ip6table_filter         1988   0 (unused)
ip6t_mark                688   0 (unused)
ip6t_limit              1016   0 (unused)
ip6_tables             13044   3 [ip6table_filter ip6t_mark ip6t_limit]
ipv6                  117992  -1


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
