Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129833AbQJ2XX5>; Sun, 29 Oct 2000 18:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129295AbQJ2XXr>; Sun, 29 Oct 2000 18:23:47 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:37125 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129186AbQJ2XXg>; Sun, 29 Oct 2000 18:23:36 -0500
Message-ID: <39FCB09E.93B657EC@timpanogas.org>
Date: Sun, 29 Oct 2000 16:19:58 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.18Pre Lan Performance Rocks!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

I don't know what all changes you guys did to 2.2.18pre, but the LAN I/O
performance absolutely rocks on our tests here vs. NetWare.  Good job. 
It's still got some problems with NFS (I am seeing a few RPC timeout
errors) so I am backreving to 2.2.17 for the Ute-NWFS release next week,
but it's most impressive.

:-)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
