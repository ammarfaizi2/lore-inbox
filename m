Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130292AbQLSVQj>; Tue, 19 Dec 2000 16:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130379AbQLSVQ3>; Tue, 19 Dec 2000 16:16:29 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:54801 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S130292AbQLSVQR>; Tue, 19 Dec 2000 16:16:17 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 19 Dec 2000 13:45:32 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: carlos@techlinux.com.br
Subject: Re: Possible patch for reiserfs-3.6.22 against 2.4.0-test12 w/ new_writepage
MIME-Version: 1.0
Message-Id: <00121913453202.23153@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For Linux-2.4.0-test12 : Reiserfs-3.6.23
ftp://ftp.reiserfs.org/pub/2.4/linux-2.4.0-test12-reiserfs-3.6.23-patch.gz

See the archived message regarding this release here:
http://marc.theaimsgroup.com/?l=reiserfs&m=97722705425882&w=2

For Linux-2.4.0-test13-preX, the following Makefile patch is also required:
ftp://ftp.reiserfs.org/pub/2.4/beta/test13-preX/reiserfs-Makefile-patch

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
