Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLTQtU>; Wed, 20 Dec 2000 11:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQLTQtJ>; Wed, 20 Dec 2000 11:49:09 -0500
Received: from office.ilan.net ([216.27.3.20]:26634 "EHLO office.ilan.net")
	by vger.kernel.org with ESMTP id <S129228AbQLTQs5>;
	Wed, 20 Dec 2000 11:48:57 -0500
Message-ID: <3A40DBC2.AEC6B3CA@holly-springs.nc.us>
Date: Wed, 20 Dec 2000 11:18:10 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: iptables: "stateful inspection?"
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IPChains is essentially useless as a firewall due to its lack of
stateful packet filering. Will the IPTables code in 2.4 maintain
connection state?

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
