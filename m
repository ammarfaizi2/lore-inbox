Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbQL2WMi>; Fri, 29 Dec 2000 17:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132547AbQL2WM2>; Fri, 29 Dec 2000 17:12:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52106 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132515AbQL2WMQ>;
	Fri, 29 Dec 2000 17:12:16 -0500
Date: Fri, 29 Dec 2000 13:25:02 -0800
Message-Id: <200012292125.NAA05918@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: sonnenburg@informatik.hu-berlin.de
CC: linux-kernel@vger.kernel.org
In-Reply-To: <NCBBIODJDAHHMNHHMKLAAEIDEPAA.sonnenburg@informatik.hu-berlin.de>
Subject: Re: 2.4.0-test12-reiserfs oops in <ip_frag_queue+20a/254>
In-Reply-To: <NCBBIODJDAHHMNHHMKLAAEIDEPAA.sonnenburg@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try test13-pre5, it has this fixed.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
