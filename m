Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131951AbRAWXH6>; Tue, 23 Jan 2001 18:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131954AbRAWXHs>; Tue, 23 Jan 2001 18:07:48 -0500
Received: from mail.rd.ilan.net ([216.27.80.130]:57360 "EHLO mail.rd.ilan.net")
	by vger.kernel.org with ESMTP id <S131951AbRAWXHi>;
	Tue, 23 Jan 2001 18:07:38 -0500
Message-ID: <3A6E0EB1.29433C68@holly-springs.nc.us>
Date: Tue, 23 Jan 2001 18:07:29 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: unmapping inode?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From within a filesystem driver, how would I completely remove a page
cache mapping for an inode in 2.2.18?

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
