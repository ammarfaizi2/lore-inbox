Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbRFAQR6>; Fri, 1 Jun 2001 12:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263574AbRFAQRt>; Fri, 1 Jun 2001 12:17:49 -0400
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:37896 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S263313AbRFAQRf>; Fri, 1 Jun 2001 12:17:35 -0400
Date: Fri, 1 Jun 2001 18:17:28 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: <linux-kernel@vger.kernel.org>
Subject: [newbie] NFS broken in 2.4.4?
Message-ID: <Pine.LNX.4.31.0106011808310.13429-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

When a process tries to lstat64 a file on nfs and the reply is not
received it gets blocked forever. Should it be that way?

Please help,
					Roland

