Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133017AbRAQLtD>; Wed, 17 Jan 2001 06:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133039AbRAQLsy>; Wed, 17 Jan 2001 06:48:54 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:15887
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S133029AbRAQLss>; Wed, 17 Jan 2001 06:48:48 -0500
Date: Wed, 17 Jan 2001 03:48:18 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Markus Schlup <markus@qbik.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: ServerWorks IDE in 2.4.0-ac4
In-Reply-To: <20010117090518.E6826@edelweiss.qbik.ch>
Message-ID: <Pine.LNX.4.10.10101170348070.17625-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-CONFIG_IDE=m
+CONFIG_IDE=y

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
